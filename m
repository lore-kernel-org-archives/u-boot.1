Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30AF910F996A
	for <u-boot@archiver.kernel.org>; Wed,  8 Apr 2026 18:25:27 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 82CDC84099;
	Wed,  8 Apr 2026 20:25:20 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="GAOmmEJD";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id CF13983693; Wed,  8 Apr 2026 20:25:18 +0200 (CEST)
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com
 [IPv6:2607:f8b0:4864:20::235])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A4AB283CF5
 for <u-boot@lists.denx.de>; Wed,  8 Apr 2026 20:25:16 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-45f053b7b90so35715b6e.0
 for <u-boot@lists.denx.de>; Wed, 08 Apr 2026 11:25:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1775672715; x=1776277515; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=s77uc0NjthGEycblOaNMEght88yp64hQF6cUp3Qh5y0=;
 b=GAOmmEJDhysteqDW59wt+fMlL9Th+ilgDxQo7fQ6Ce+RULi17CWf0xVC7KOVTlA3qS
 t29tNprf/DlFEcV6rd6HNhlKKDOU/Org0kDfVP+EY1GrJhm4N7pnkMu5n1Z3bIonph0O
 /TEoqi9d01ECda8otuP6YYn+L1wsqrJbMVzv4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775672715; x=1776277515;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=s77uc0NjthGEycblOaNMEght88yp64hQF6cUp3Qh5y0=;
 b=jMOwClIHVZvFNNoSZu2TwuJVSHGq71k4O5H+stgtI0YmdJI57PUeUXZHr5XsC8Xxu3
 r+KVnP2NiCRDgANC+NxF10TrLSX6wwfA8Vxj+PW/i0jpr8NOIlyN5AanNXJguSBG9AWY
 ujZ0nVQUKmPGdzbzIDPFPC4gL9cxTourC9DaPlWLqVIln8BeEoNe6/KssCw0vsYkVnhC
 KUw43aTa2SaF14HaPObv3LqVSZVZPswouuVceR/6E66kJI/ii+FpzYHkthk8cwf2Ybt0
 VBcLC3pQxj6b0G3XEluZEmjEp8lGenOj7KAF9uVLueuZqcI/h4ZXWKKkcCmcZIlXn3qt
 CNVg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVkkuxp7LXvRYgdeLaiup4az02C1j+cv60RKKBPC1cbQYLXtNPU5AsjA7D3oalJsixq4Cy/AFo=@lists.denx.de
X-Gm-Message-State: AOJu0Yxd2iyd9CrFWSULvRUoQkS5nk7YjLoO3Mgn2dla6HlLVE3uUJ4h
 IqChBIC9pdmE5rFjA3QkW83Cd/7E9pfXE9R3wj0Yirgjuw4I25cA+YhLPjGyuW6Rsoo=
X-Gm-Gg: AeBDiesMif/jHaJMzH/qTUCjz1jEm1HGt+FQ8ikHDvJ0xnt5BnWErVXneW3nVukB7ZO
 ATPshH/ZCf1QPubXBe06lYbYcMO/2BmIsvSmNXln14+4sTj7vujlb/WKQnKjn5bb5UulDpe4HzV
 H2oDbSIJozn44DQdQkerHlJZyvox1cqHjce5kPrEpMV0VT4m+C9+GqfUd8baTnu2CPJlO2U44g3
 HV6bRU9J5gQySBHHNA+SJjpgyjac6QDsGmCYq/igHpnsHeRNiqOYiPKDlLP5RFL15uwgnFdYDgc
 1lP/6NRQhyrTHp4nx3lWMdOykIMtkBYcBXzf2io9LqxqlDQWL/dzKtusaMukzjiOUMZdm0jaB9H
 m1B6TdELDdQVojb0kmBPe6fMYxGn+oyBWyitrQP4psnMD1YqrXbvTVgn8yTHaYwly5BUkJrbjxo
 AVnE4jHVjHrxO9gyykDd8Cwa7XgPdWdsDbJLQ31gxP4NZ4RoTbZ4yum/qpy1iOAt7+v8AngcDdP
 lmjeyeQzRmeubdR9or++6vkGy8rlwYDYD/tObCWjrMNQXVl4Q==
X-Received: by 2002:a05:6808:4f14:b0:467:880:7454 with SMTP id
 5614622812f47-46ef5ff62a7mr12803889b6e.18.1775672715364; 
 Wed, 08 Apr 2026 11:25:15 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-472813cdbe7sm5953554b6e.7.2026.04.08.11.25.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Apr 2026 11:25:14 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Casey Connolly <casey.connolly@linaro.org>, 
 Neil Armstrong <neil.armstrong@linaro.org>, 
 Sumit Garg <sumit.garg@kernel.org>, 
 Varadarajan Narayanan <quic_varada@quicinc.com>, 
 David Lechner <dlechner@baylibre.com>
Cc: Julien Stephan <jstephan@baylibre.com>, u-boot-qcom@groups.io, 
 u-boot@lists.denx.de
In-Reply-To: <20260326-env-scsi-hw-part-support-v1-0-55c9dd07a2cb@baylibre.com>
References: <20260326-env-scsi-hw-part-support-v1-0-55c9dd07a2cb@baylibre.com>
Subject: Re: [PATCH 0/6] env: scsi: support SCSI env without partition UUID
Message-Id: <177567271440.827346.4023099257253353387.b4-ty@konsulko.com>
Date: Wed, 08 Apr 2026 12:25:14 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On Thu, 26 Mar 2026 17:59:22 -0500, David Lechner wrote:

> This is a series adding support for reading U-Boot env directly from
> SCSI devices that do not have a partition table, similar to how we can
> already do this for MMC devices.
> 
> The motivation behind this is that MediaTek's BSP is already using the
> same disk images for both MMC and UFS devices, so we need to be able to
> read the env from SCSI devices without requiring a partition UUID.
> 
> [...]

Applied to u-boot/master, thanks!

[1/6] env: scsi: rename ENV_SCSI_PART_UUID
      commit: ad4831d7a51d53bdb5ed0493fdc7bb510ce3f9a5
[2/6] scsi: return ENODEV in scsi_get_blk_by_uuid()
      commit: e5d8ad260bb7de1729a6454e8b95a83e629dff7a
[3/6] scsi: document return values of public functions
      commit: 7b824e75056a45d7c40eea9014edffa1b5289750
[4/6] scsi: move scsi_scan() call out of scsi_get_blk_by_uuid()
      commit: b382cd0973521a5197a097d4e190f47aadb79757
[5/6] env: scsi: add CONFIG_ENV_SCSI_HW_PARTITION
      commit: 83223d4f86980f09fdf341b64f69e03313cac14b
[6/6] env: scsi: document requirements for ENV_IS_IN_SCSI
      commit: d72c2b63da5c004bb41855577d4fd783598b004a
-- 
Tom


