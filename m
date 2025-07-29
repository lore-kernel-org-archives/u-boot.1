Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 931EBC87FCA
	for <u-boot@archiver.kernel.org>; Tue, 29 Jul 2025 21:13:39 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6AB4E82B20;
	Tue, 29 Jul 2025 23:13:37 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="WyZcOl8X";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 3CCC482BCD; Tue, 29 Jul 2025 23:13:36 +0200 (CEST)
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 0E55082B07
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 23:13:34 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-740ecfff873so3858715a34.2
 for <u-boot@lists.denx.de>; Tue, 29 Jul 2025 14:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1753823613; x=1754428413; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cWkjAyTP1hqgDPMtYiEal4DmHGF4/ixABAJgI7wlgXo=;
 b=WyZcOl8Xjqy88MKHTOapqIvKDC9mBQe/JWVmc66CXWb5Qg4URe8syQaoqQdO3ak43a
 gJEJ7CN3MxSEAwrWE6dMSRJLV4w0T9ToVYauNuApnrJis3utiNMbz7GqR6vjI0EXOEVv
 SRL7TeWxVV/13qsFeOYnhryPx7TipVm8fDNfg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753823613; x=1754428413;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cWkjAyTP1hqgDPMtYiEal4DmHGF4/ixABAJgI7wlgXo=;
 b=KFv2dn8gLh8XhXcOSqmBYHO+sMsOksC8WImpgA7D6dLmCv+0D+6yockxWX8+J55dEu
 cwEQUSiIi04UDlfgeZO6ixegngFTh50wE5IZCIGRqGKBuOPT2IICuhxVRJbxV2a0QO/n
 +ghk/LLWhiKrrG5NJ24xYJJefdJGZD04fTOzlUdRkuvcizc8RAlQp3HDGizbXjyv2sOo
 aTX0nsjKfDlm7iT5Ow8BUXBWObPIUeogZcDExZWxt6XFkXJbYvSe8G7xdXnMoC6Pev3e
 CqCOWRUFOsrlroB//g+AvcrU53AAnts7MpETeO7rF+nbMz7rIaL0YVg6lDTUwBnzGnKf
 owlg==
X-Gm-Message-State: AOJu0YxiU/TxXJBunBJ/2bgHev+NusMFlA/9sIBSoIko3f44Fn/OS/19
 GWtR0qaRD+kyEktRN68CurR9XkC0allFKjuRZzZ4GV6nJsYct0W6EvIJaktxKuLsMcY=
X-Gm-Gg: ASbGncuF6eXKQOxSVZD6cEb1g1Z60xXvfYmJ1IuTLbfgbmiQLMqNDoenHqADKE7mQQz
 GuCvJdDZ+A1zMPUrffV+tjmVhOFlK5QX56KdxiE25ukvS87VolM1Zcs7y8DNNVMJPzzh/Y8e3ar
 DwGsPaSdiz9xYUm1jxMgMSBD9kgoqciPic9+3MKh5QBZfYMCFyRHpvkC0+etL7RRlBVsfPidXbY
 wUCdZa6iJ8oAAOjye/PiLfQdfTkEE1R4OCuvrl1Ae4lTvEbb8ZUtbFCk7zRT5it+RWB8lGJMFbF
 79jmA1J3Ps4Da/GrLsUHb21Vq3+Z8tTubjID4LHiyqvai9ssImOIX0ZX3Ngw1D0Q8o+jVi6Wj3y
 EySCFh8vmp91/2W0NFIPrCBWgEit7NDnA7tgwyMU5QeMi6G04/f2q93CrakmQeNsi7Q==
X-Google-Smtp-Source: AGHT+IERemXGc2ESIYOVxO9/S9QMeEtqvlAPAUdaC+l0YeT0JJmYUCdrFYh1IWjfLuRoJh7G5yAwnw==
X-Received: by 2002:a05:6830:912:b0:73e:9ebd:9f1e with SMTP id
 46e09a7af769-74177b2ff9bmr969228a34.10.1753823612728; 
 Tue, 29 Jul 2025 14:13:32 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-97-42.totalplay.net. [189.203.97.42])
 by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7416dce11ffsm404756a34.57.2025.07.29.14.13.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Jul 2025 14:13:32 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Andrew Goodbody <andrew.goodbody@linaro.org>
Cc: u-boot@lists.denx.de
In-Reply-To: <20250718-spl_loader-v1-1-835ff557b9f4@linaro.org>
References: <20250718-spl_loader-v1-1-835ff557b9f4@linaro.org>
Subject: Re: [PATCH] spl: NULL check variable before dereference
Message-Id: <175382361195.2002397.15773328500688056416.b4-ty@konsulko.com>
Date: Tue, 29 Jul 2025 15:13:31 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.2
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

On Fri, 18 Jul 2025 13:19:54 +0100, Andrew Goodbody wrote:

> In boot_from_devices the variable loader is not NULL checked after
> assignment and before first use but later code does check it for NULL.
> Add a NULL check before first use.
> 
> This issue was found by Smatch.
> 
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] spl: NULL check variable before dereference
      commit: ae409a84e7bffb0c5a0d420d72806ac7b854f619
-- 
Tom


