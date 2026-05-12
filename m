Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12BF0CD4F21
	for <u-boot@archiver.kernel.org>; Tue, 12 May 2026 19:31:51 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 8A12083E81;
	Tue, 12 May 2026 21:31:49 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=konsulko.com header.i=@konsulko.com header.b="EoD9ojyv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 617C583E81; Tue, 12 May 2026 21:31:48 +0200 (CEST)
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com
 [IPv6:2607:f8b0:4864:20::336])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 576F18341A
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 21:31:46 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=trini@konsulko.com
Received: by mail-ot1-x336.google.com with SMTP id
 46e09a7af769-7df05fc49e5so5644952a34.3
 for <u-boot@lists.denx.de>; Tue, 12 May 2026 12:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1778614305; x=1779219105; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IFcFP49Sx6mbgVXwkM2A5Tevude5ot50c4UIRAZvVmg=;
 b=EoD9ojyvVtTzk77JNCSQLl4ZQzHDJq3TBfvYiwKPV25SsaDCxViL2UTWm4yRtSVk3L
 mPZMtoXh9BnToOMdfZ+Kc7pCV4ZmhmJRbyrDyRw5Wyaay9pn5AmyCHJnGRxBM5EE9+Em
 tSfrYzutaO0K4DQ88Afc3BOlaPtlgHNKB6FRU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778614305; x=1779219105;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IFcFP49Sx6mbgVXwkM2A5Tevude5ot50c4UIRAZvVmg=;
 b=N7+5Dw0Ynzfq+daEdwOP81YA2V/L4YqAMWwR+yJkl4CBmDCAqNfXwvlk1FjQLumbMp
 JWTBK8Ofnqiemqb8XXsDXy4RuRnczO1Y3NcRtA/tellrX0mSSsebtF9oY2zqvYJ766nz
 dRmPcMDap4lSzKu1G9MzEfYdtFSkGe0QyfKj7ckmDCh7/QJSV9r3olWjEtB7DtXMJvp1
 8rnlDDpTDOqdcBsLfqJUOTv3/1wXmXrL/PvEQS9oQBb3DrnFfJ+bbTzi8VVnSd7by9sn
 rIeGGwPjAGUUoqrUV+2UmPjJpsevwW/A+VGbycVmfZsehjkyaM+aqTFfOtJmOmQQ5lmX
 F8fw==
X-Gm-Message-State: AOJu0YzNes1I3/CTfEraykfTAmCuTp5ibpjrsOUqbg6yemc1hFH2byMh
 zReeoVKdMyMlkf8zZI2rHV1lO8bEoNixFRdXdnZajQL2/DaUiR8+QKnxRS4Cs30OFhJYgPkKP4u
 KlkN7MTIHwdQG
X-Gm-Gg: Acq92OGNhHCTQOzpz8/PNRtAwqHMjlZ9r5NEgrVIG2Z5zzADsvZgQTM+HkX+1hwL+3T
 yO8D8BpuqjfKVD92MQqVyVrAC5QodQAu0PBAh9hHIAtlRljp7c+PyAkWBjF4k5wBqDQWO7Hcox8
 33kRe8ag9msr3lTyGMMQNPWR7d4rlaQNtoenxKMS6v1FKUh6RzyzvDj/LJV4d8fck3su4ZrqnRQ
 mcXe0anUGE3yjERzegaaaBVRN22M/VzDzBVdl7/rLuydrRPNZEMFihC2UmHyZxYYzOg7jZCyyLN
 l0z8z0IXgZPQlFl5pCfdVXs07jSSIoOm+P7EEpOGTcpLFcGA3i4OJ+cyZ8MhVMFq8eaQtXegnYy
 xGqTbWSCPP8YYAiEsS/Wt2e0a7lUr6QTT4vnyzwFP8LWwFJmIKY/HjxsE3AxDvTuJG2odxJjIiG
 FuSY7yXnb27eJWIBouhvNR9soXjJjwBHCQFo4e8CRbMAgsYIXRH5esZVNnf+BvHwf4BMxNqkb06
 uNe13yEyNCfAJ7honlYYhEGC1/ffvhkbq6QPzFx4+1fc1IfLQ==
X-Received: by 2002:a05:6830:67ed:b0:7dc:dd58:50ab with SMTP id
 46e09a7af769-7e3da439f6dmr32070a34.14.1778614304987; 
 Tue, 12 May 2026 12:31:44 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-106-235.totalplay.net.
 [189.203.106.235]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7e367d4f05csm10369170a34.17.2026.05.12.12.31.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 12:31:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.denx.de, Ernest Van Hoecke <ernestvanhoecke@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Franz Schnyder <franz.schnyder@toradex.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Ernest Van Hoecke <ernest.vanhoecke@toradex.com>
In-Reply-To: <20260505-am69-combined-binary-v1-1-5b5dc65bcb19@toradex.com>
References: <20260505-am69-combined-binary-v1-1-5b5dc65bcb19@toradex.com>
Subject: Re: [PATCH] arm: dts: k3-am69-aquila: add combined boot firmware image
Message-Id: <177861430413.3279584.12872811326250477219.b4-ty@konsulko.com>
Date: Tue, 12 May 2026 13:31:44 -0600
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

On Tue, 05 May 2026 18:36:24 +0200, Ernest Van Hoecke wrote:

> Add nodes to the binman configuration to create single binaries that
> combine tiboot3-am69-*-aquila.bin, tispl.bin and u-boot.img into
> firmware-aquila-am69-*.bin, with the proper offsets.
> 
> These binaries can be used to flash U-Boot via a single binary of three,
> as it is done now.
> 
> [...]

Applied to u-boot/master, thanks!

[1/1] arm: dts: k3-am69-aquila: add combined boot firmware image
      commit: f62d4535cf172cebc7d7d752020a39306444b096
-- 
Tom


