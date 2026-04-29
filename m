Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 909E1FF8867
	for <u-boot@archiver.kernel.org>; Wed, 29 Apr 2026 08:49:19 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 2064F84701;
	Wed, 29 Apr 2026 10:49:18 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jG7NkrVI";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id D08F384705; Wed, 29 Apr 2026 10:49:15 +0200 (CEST)
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com
 [IPv6:2a00:1450:4864:20::32d])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id CE180846F8
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 10:49:12 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-488b0046078so110480715e9.1
 for <u-boot@lists.denx.de>; Wed, 29 Apr 2026 01:49:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777452552; x=1778057352; darn=lists.denx.de;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=O8MwWGoJVWyRkGrqIt5BfyjhjdUnl7YjIVcE3B7Uvrk=;
 b=jG7NkrVI9IAO1FvDEm+EF76Eyg1nnIkungUR2MqkHXVhr7dJUlOeEF855zI9JMgr1Z
 o6BDv/GV0EwT5/c8MODqcLsUtzjXlUuAvU0Abdc0v8Yq9rTXqF7HKcSiNN/kfAR6igmA
 nVHvCxkGRjM4sDTWLwPSlWZ4OvXd/ZEtWebBF9mzwbjv2TZehofq2cNC2z1V6Gigml5/
 Z3jV2uccfTrTpnW1uHu++GOztQT725a28Fo1HMERV/+zx3VqT5BfjAKdTiskDVacQH+B
 VATnh7ArNs07zP5JbbU2iXwHkiVGE3Oo8UVwGc6wj31kO2aPX/gNe+DY4NoKgFsqJMjv
 GgRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777452552; x=1778057352;
 h=content-transfer-encoding:mime-version:date:message-id:subject
 :references:in-reply-to:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=O8MwWGoJVWyRkGrqIt5BfyjhjdUnl7YjIVcE3B7Uvrk=;
 b=qwS0BmzgdWDaaOJCrwW1VzZYpGMzm23LOV+hk9vvJb0afILir5DPif8PbCyFbescIG
 OXVqzCq6DOktSrJ/eLrXNgnH/d68pMZ4xpmztzO3YLGIBlqpAdRfQII3YdfM8ca5jupE
 efcS/r8cJRZebr7vqV2sW42ADJTBNosSagVMTcwxrTx/9sWXhIe4lN2Qm9zFomsqENgc
 EcCmVhmzlDkCESdHP/RofmNpXG7RSTkRmwdQ7q4uiK3EJ2rFKYTa0EvVSmTULqinveQn
 TSJ2zYHJyALMAIBOftNRJC0g1DrpUDDM5XYraDSe7Zn0sjB5L4A9GSW5tuum+jd7d/oZ
 nvvA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+1y/0/VLK70fBwmH4f3N7PpBVjl8iksEGv2kGikIlzeUhha3X7O4OphSlBxpY8yL2aJp00H7g=@lists.denx.de
X-Gm-Message-State: AOJu0YzXWH4FUaHIUjjuhPsx0w4ni0GWUauC8dTyIzlHTbbvUsrDsRfp
 EovPyvBAJTCPPlTd4DavS59Zr2z/JlbomkWQ4LXH9OPr37G9QDfwfuM2EnNCHfTYjVA=
X-Gm-Gg: AeBDieusTLvW8brIhz9nW34nAj6HQEaB3RXetsBpX/tPCJO0UPVNizcXrBsWcYQvs//
 HgXvG3y4LZLPAZgrg8miijwE+ee7UizsMXmWi8TgBqtNU2++a2f1qeDMYAHhj53IDneGSBcxb7P
 RPMoNLkyTqdXQg4cZI3ku/td06JJBjMc2tQ2fA52ANBpJg8aLAkpRgIMtS0od1Zc9zAwAgIxXTG
 6dSVVXzGqj3Ukbmv/yvCWRV2INEFSe8YjFCgYSO5yKRJvslVHmj+YtDB0pePig3T4ZtthMiXS4l
 awGFUxPETzbRL16/eTN7rfSuwi8Ye+ETWgOF135hj/gFFbY4eaeXTJZQfMj/HBIY/rsGrtz0J7t
 Q+DwYdCnFpPG49PKvfKCTQT4HtE7tTDXBoW6aA+lsl2RRiEtWfGiuXlM6dGXUMV43mglKOXMSq6
 kefMF3pGlFGuXjrXUlKVoTKpXIyi6RIgYWKwlba4E9cbR6wH/BZ0aK4HVsyhBIGAJP1ObXQDe/b
 SlnMS8=
X-Received: by 2002:a05:600c:8b2f:b0:48a:58ae:9933 with SMTP id
 5b1f17b1804b1-48a77b1990dmr101820475e9.18.1777452552289; 
 Wed, 29 Apr 2026 01:49:12 -0700 (PDT)
Received: from lion.localdomain (p4fc3dd86.dip0.t-ipconnect.de.
 [79.195.221.134]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-447b120bdefsm4411805f8f.0.2026.04.29.01.49.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 01:49:11 -0700 (PDT)
From: Casey Connolly <casey.connolly@linaro.org>
To: neil.armstrong@linaro.org, sumit.garg@kernel.org, trini@konsulko.com, 
 xypron.glpk@gmx.de, ilias.apalodimas@linaro.org, 
 marek.vasut+renesas@mailbox.org, michal.simek@amd.com, sjg@chromium.org, 
 mkorpershoek@kernel.org, jan.kiszka@siemens.com, paul.liu@linaro.org, 
 j-humphreys@ti.com, u-boot-qcom@groups.io, u-boot@lists.denx.de, 
 Aswin Murugan <aswin.murugan@oss.qualcomm.com>
In-Reply-To: <20260324175913.92858-1-aswinm@qti.qualcomm.com>
References: <20260324175913.92858-1-aswinm@qti.qualcomm.com>
Subject: Re: [PATCH v4 0/2] qcom: EFI PSCI runtime reset handling and
 config update
Message-Id: <177745251949.126665.5548216082597899104.b4-ty@b4>
Date: Wed, 29 Apr 2026 10:48:39 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=1036;
 i=casey.connolly@linaro.org; h=from:subject:message-id;
 bh=G0DzWr6H1FuMva2Hu951ji+C5v4QTW3/IK9KfBvhXc4=;
 b=owGbwMvMwCFYaeA6f6eBkTjjabUkhsyPx9iD/76TSq888PF8XDXjArnuyBmvnx4MZTqStW3nq
 bBpe7/96ChhYRDkYJAVU2QRP7HMsmntZXuN7QsuwMxhZQIZwsDFKQATMfNh+F/DU/J6hlpw9/fG
 Axnl1d5zK5+9VtJx5e5hi17z43CLSAvD95LFDApmaREJy0PWbCnuush/9Vnh7ttXv156k3/+c7y
 nPQA=
X-Developer-Key: i=casey.connolly@linaro.org; a=openpgp;
 fpr=83B24DA7FE145076BC38BB250CD904EB673A7C47
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


On Tue, 24 Mar 2026 23:29:11 +0530, Aswin Murugan wrote:
> qcom: EFI PSCI runtime reset handling and config update
> 
> From: Aswin Murugan <aswin.murugan@oss.qualcomm.com>
> 
> With CONFIG_PSCI_RESET enabled, EFI runtime resets always use PSCI, but since
> it cannot pass the arguments needed for special reboot modes, requests like
> bootloader or EDL fall back to a normal reboot.
> 
> [...]

Applied, thanks!

(applied v3 not v4)

First and last time I use b4 review, the commit shas are wrong but you can find the patches in https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commits/casey/qcom-main-13Apr2026?ref_type=heads

Apologies


[1/2] efi_loader: make EFI_HAVE_RUNTIME_RESET a user-selectable option
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/6e78ca4ce06f
[2/2] qcom_defconfig: Disable EFI_HAVE_RUNTIME_RESET in qcom_defconfig
      https://source.denx.de/u-boot/custodians/u-boot-snapdragon/-/commit/f0f7134acb1b

Best regards,
-- 
// Casey (she/they)


