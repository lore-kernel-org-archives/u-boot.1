Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 484C7D0BB5E
	for <u-boot@archiver.kernel.org>; Thu, 24 Oct 2024 04:58:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 716AF892DE;
	Thu, 24 Oct 2024 06:58:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="OuE0TnAI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5DFC489323; Thu, 24 Oct 2024 05:57:58 +0200 (CEST)
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com
 [IPv6:2607:f8b0:4864:20::b36])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3C30688B8F
 for <u-boot@lists.denx.de>; Thu, 24 Oct 2024 05:57:53 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jayaramudu.d@gmail.com
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e28fe3b02ffso506422276.3
 for <u-boot@lists.denx.de>; Wed, 23 Oct 2024 20:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1729742272; x=1730347072; darn=lists.denx.de;
 h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=jZHQ84DRIH27G5vgM8WbJNrz1h7tWpUMi0UuoM9LBI8=;
 b=OuE0TnAIZjGwpjjLvXta+Mz5KGTSfaNfX7mu63Thjbmp08f/pXVONRJ+HmlPvctXo3
 55HgHkURhGmRv8cl4T3a0OgWVHMaPL1myUJLc0c9dHo6Z2GQTWHPW2pmkhIEHlWPR4pC
 kVNklxaWvqQTVTu4HYN5MmD8k7WkT2/f3ft/SODs998Son4PnJni7wYF303dI3nYaun1
 qROh5iiC6UwRdN7HXzjJcHHOCmU8TGT72cU3543MIrWNVnOAk5wG9WDQX2iUXLTf/F/2
 YVhgkr1rdHYDE4IscFROH/zJawgpkqep/onwwcJ0HrntATHMpGChVSv1aaevkt4wgjGv
 /mew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729742272; x=1730347072;
 h=to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jZHQ84DRIH27G5vgM8WbJNrz1h7tWpUMi0UuoM9LBI8=;
 b=RixxN7G36IJX3TlV/aFGpM/oCJRXe/gtsvu9ePMVXEvnitr5gWDa5uot+ueV5n4hSw
 pUHerDwovxWsN9Sra24nXhRjKWskL/tZIXTrrpZzuLRNhRK0D8mQlUfDr7SzuZI1egm/
 DhNc/hMEEfeNFHFSNf5iqdt9+KqyyXUY3ZEdoaLdtb3Ub9TKJvDtG0VaPj6TaEHNvAWM
 qxnp+zYQi8ksQStLWpt7qfVTCnc4kpJkX6W0hijzNrCYRXZQapfFMYIv05OsHHQhqGZX
 A3GUqil2TgpvNuH0rglLVyCxXUeB4lOJah9lr9Zh4cTOKVXVCJ3ElcJBZSViXAUEXLDK
 3Luw==
X-Gm-Message-State: AOJu0YyQSOpLsqUuJbo6h8XNSSmTPIZ1e/P0QSf4BmhmlrplmT2PZng1
 3yhQnNK7FNtZ8AKWImn/9WarwTyvsD7Qqf7npu2Xn59EDlOfEWrDykZx1LIrZSmmrdDPbvm5TpY
 j9yaMx3VrpaZoxnKqvBxWm4Sz4aP0lorC
X-Google-Smtp-Source: AGHT+IEawo/Adah6tms0wPf4uomr2zBsgV6MK4iwhfbQMTpTa0iRAP5jzbWyAh30yDwCtYcHhPw9Qat8kkauctKe4HU=
X-Received: by 2002:a05:6902:178d:b0:e20:291e:7fe1 with SMTP id
 3f1490d57ef6-e2e3a65b32bmr5072334276.25.1729742271817; Wed, 23 Oct 2024
 20:57:51 -0700 (PDT)
MIME-Version: 1.0
From: "Jayaramudu .D" <jayaramudu.d@gmail.com>
Date: Thu, 24 Oct 2024 09:27:40 +0530
Message-ID: <CAB2y086kRpFK98gWm-8FVfC5me0UePwDMZdouvm+PkstaZkiEw@mail.gmail.com>
Subject: Pincontrol driver
To: u-boot@lists.denx.de
X-Mailman-Approved-At: Thu, 24 Oct 2024 06:58:33 +0200
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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

Hi,

I am working on a board which AMD soc, trying to enable gpio at uboot, but
I did not see AMD pincontrol driver in U-boot 2024. Could you please
suggest any info.

Thanks
Jayaram
