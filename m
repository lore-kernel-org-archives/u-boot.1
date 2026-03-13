Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC81107BCE2
	for <u-boot@archiver.kernel.org>; Fri, 13 Mar 2026 20:56:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 5BA8D843E4;
	Fri, 13 Mar 2026 21:55:19 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="q5C+sb58";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 9C59083DA7; Fri, 13 Mar 2026 21:55:17 +0100 (CET)
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com
 [IPv6:2607:f8b0:4864:20::32e])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 50EA784382
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 21:55:15 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32e.google.com with SMTP id
 46e09a7af769-7d75e74f5adso2638232a34.3
 for <u-boot@lists.denx.de>; Fri, 13 Mar 2026 13:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1773435314; x=1774040114; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iQg6gZTLiN7unNN1GrSkknxc6VXQvksrlIzgb6bVS3Q=;
 b=q5C+sb58tMmLrDfPhEJzsqIWcRcUVDDRRsHdnGiLhbpHNO0GdHiFMYWQ67EiB01Pgc
 DOzgH/M0w6jbsfux52I3+CuV+ZO/IQqvbqAr5LxHjDg9MMSsNUOkLNNZ0mBngd5ABNJY
 qFF7eUhXlXfCRHKu9yPr2z5y8yq5TyzbQ+VeA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773435314; x=1774040114;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iQg6gZTLiN7unNN1GrSkknxc6VXQvksrlIzgb6bVS3Q=;
 b=WHfqhaws6raWNXbes7OPmmNLksmolg4dp9Z/7dL8ikuV+4IXJYCbVc3CM8+7/DRhqk
 x3Y75sG4eHvlASFpDYeVopZ0BTlvGItGz601A8nB58gnWQMFWGRZ9l/KP219zuFv8bsP
 b7iAu5pgV7WgGUfclHIeNlOVf62Abq2AT64PlDu5J8mYiEmLSrYILMOJBNL6pKTqdUJH
 oyhfY780ufIdUTp3vnMMAniLDZDq/W1Tr/vt7dAzTB874xpzSPeffyH52ZyMMKOyyqWw
 DwWP4yFUuwPb2yQK8PllU8n6mnc5J0uIStnQm/7WPRPmnNhyQ8Zskt+Pwwmko1iUvDwr
 tnpA==
X-Gm-Message-State: AOJu0Yxljnu5AbhpRbxkz+51+dEZKkBwvROuIFLdJBUQSxJJUOsFNCWn
 usags8l2NEURcOjvYEHwF7SuT+YYziP4UxAKX4ePr0qilydd7XpJJIwMis8702gE5RY=
X-Gm-Gg: ATEYQzw+fcU+D+FkkXg9AJZ+gCczjanyMUqRPbqCbPX7QnIUJ2kJVPFaQiFW/bi+b4+
 X8jeibUoXwhEouGYtratvf+Sz8bwI+mMzO+cl4VjyZX3hsMgjH+/MWHS534Qz5KEaa40wPwq8UG
 Hi9quqWKNByhK6Pjw3/oA4/KD6Axl0wdaj/vo5jFFxM6h7j9EHPtN/CzsabFLaAxCFk+HC9trFA
 ZhfgCyH+txpq+XnByCZFcyHJN+kMSOEfRlC7UCxKuxViqFQ63AkIvk+j3QD4O983gsYyB9IIX3N
 0aexXfyO9dNX34hT3RLOf3/QYMwo16UAB6jLeNZ0cfabyiOv1vZ/cMpX8TiL1b07g8fkLZp/6oi
 A+SueCkd2mWMZit1StooRp9E65+LgGsoz+p1Rqi8QEimObCn0Wg59Q6+GIS81+zcgXgqZBUy7RB
 zTSuSdRC0TNJUEVXEaYMaL1m+YwjSP+gYXIl0WpSDQzJr9UXCV16Kui/ZFdrstkl731Gh/3yvtw
 t7+YINTPty9RVX6L0prCFVefUVcqOaHZCNOdMF0i4rCt98=
X-Received: by 2002:a05:6830:f93:b0:7d7:5032:cc7d with SMTP id
 46e09a7af769-7d7824e7de0mr3265559a34.14.1773435313823; 
 Fri, 13 Mar 2026 13:55:13 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-235.totalplay.net.
 [189.203.97.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d76ae3a18bsm6857942a34.18.2026.03.13.13.55.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 13 Mar 2026 13:55:12 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Caleb Ethridge <jcethrid@gmail.com>
Cc: linux@analog.com, malysagreg@gmail.com, philip@philipmolloy.com, 
 Caleb Ethridge <caleb.ethridge@analog.com>
In-Reply-To: <20260227193423.5712-1-jcethrid@gmail.com>
References: <20260227193423.5712-1-jcethrid@gmail.com>
Subject: Re: [PATCH v3] arm: dts: sc594: Update sc594 EZKIT GPIO polarities
Message-Id: <177343531234.1131472.6688781597965013120.b4-ty@konsulko.com>
Date: Fri, 13 Mar 2026 14:55:12 -0600
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

On Fri, 27 Feb 2026 14:34:23 -0500, Caleb Ethridge wrote:

> Updates the polarities for the GPIOs on the sc594
> EZKIT carrier board for the newest revision, Rev D.
> The new carrier board revision has different polarities
> for some GPIOs. This patch updates the sc594 entries
> to match the sc598 entries that were updated in a previous
> commit, as both SOMs can utilize the EZKIT.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] arm: dts: sc594: Update sc594 EZKIT GPIO polarities
      commit: f3bdde84af91b095a3f4ac07232c49b7ff13f7f4
-- 
Tom


