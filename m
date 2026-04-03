Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86094E8536A
	for <u-boot@archiver.kernel.org>; Fri,  3 Apr 2026 13:19:11 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 9C06983642;
	Fri,  3 Apr 2026 15:19:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (1024-bit key; unprotected) header.d=chromium.org header.i=@chromium.org header.b="EyTneUL0";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 089468382A; Fri,  3 Apr 2026 15:19:08 +0200 (CEST)
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com
 [IPv6:2a00:1450:4864:20::62b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 5FD798341A
 for <u-boot+nodisclaimer@lists.denx.de>; Fri,  3 Apr 2026 15:19:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=sjg@chromium.org
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b8f97c626aaso318128366b.2
 for <u-boot+nodisclaimer@lists.denx.de>; Fri, 03 Apr 2026 06:19:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775222345; cv=none;
 d=google.com; s=arc-20240605;
 b=Ov/eyMntdrKRxkRzhLVBhGCpjKpLC6xn0KRpEE6KxLTnHkzs5Adc62vAKIKe3HzdAu
 CgVqL2HXP7uetwmcv2prC5HPZ7BFJs0iNO37Vj3kTJTibY8MPPk2xuZ/sOP2lysmTEsf
 PWl/PrvmgNcnO0EiZp+F92n/G6ou/VqtxpN5s/sDmsG2uhpfVlTZFxjPF8MgfpGYOt4D
 S6YfTQucmj2niDBk2Csww4qUH0Jsq5hivzD43Wi4UhezlHNN1OgB+EVvrlTZfxFRV63O
 8VzrA3Bj104SBmulXzLVCQyOtD+RKRVnOCpqbFsgnmOxW5wTl5anCe4tJSQWv/vXcrLZ
 m80A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=IZn/uk8/ScR+0b0BieN3kkXFpqM+zLUzrT5Byl8BLKU=;
 fh=CEYrxjkbFXXamzaU0tA37GtKS4sPdQpI7NNuBtjunMc=;
 b=DSmHXXsDDVNNIdARFCCgr0Gpc1AuwhwMaPnK+3b3U2F/hXad8EuNw/5mtEaoyuXJjd
 L3Xq9HD+HY18rEhUG27yWSfBmOaLfl3QdJgolSeT+m9bLQodtLrW2BqeAt83Yj6Ew4RJ
 TgTZSP7m+nrFwP7QpIkAfhqqFut6dj8wlrK+EJPw2Ab+8VSU0vLuvvwbDO4JEQlSojKk
 GBxe+yAUxvd2rRyQCuG0iwDmDTwa0kK3orGvjUWhuxDapfX9DXt3QafS246dC+BPWxdx
 fehpZ3E2k3BWYGuELIC8Z/W5r9gsU8u9WBXMXN059W3wYhylmJevEFiV0cL83PKs+5LV
 j4Ow==; darn=lists.denx.de
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1775222345; x=1775827145; darn=lists.denx.de;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=IZn/uk8/ScR+0b0BieN3kkXFpqM+zLUzrT5Byl8BLKU=;
 b=EyTneUL0+LZZZOa8NQpI2ic0GcIXMhorrmj65/CmpV96HpCgaSKa5kUxvP/z+4ZLko
 bkWkcUsEjMiN3l7+c7kknedsbpr11GwqugDTfTlNtLmEmPGV6KjPb2P0I3kQwTT5irJR
 hkTCYucf3ouHnbimCJoR2lOtlgTyioXVQNHtY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775222345; x=1775827145;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IZn/uk8/ScR+0b0BieN3kkXFpqM+zLUzrT5Byl8BLKU=;
 b=FgG1LMHcmXCSTMn4CWMUKLauUL5V1WNFRwSvdPGs5nerAjB/W4tkqhlbbcDklhlE5w
 vmy0J6CuEWDSyf9ZV8TbIRPpAKcynpn2nKPelLDMNu5u8EIlL7x6sVphZwRCzI18PbMg
 qr1icS49P4chfaDvV0jw2IU7azCsHmpulJVXcbtttBpkWRnsqIsq/zhGzwa04TLkjkKa
 RlHvGMcc6zOrB86omQGL4MPA2KSB8eVLKZFiFh2G5rh5FMorTICD+LiQw2fAN9fT8Lsg
 6q1Mu1Qrxg4eJLugNie1b1qQyTiJ1gtT96xaV3dDmSvIUgjKrWvWtdf3odkqLF38ke8Z
 KTEg==
X-Gm-Message-State: AOJu0YwMoGMJiFhHq+2VMyCaazZLtSk+6HtR8q3rrtxNmpI2iWWkon5r
 WBSvKk9zhcEyTr164ca1UKDHeVYouGaIXDs4qkeFnTOq31vJIs3apYWZ5NIRIsqEyHrhd8ZuUuk
 KKEVGclYt81AM7G6w1yr3RctIzPXPMh9ZmgkKXLFc
X-Gm-Gg: AeBDievgS9te4rXmxJrrRKHHh/BvN58s4Ohr6Jp/DG5GnhjdtUtiCIALtc64Hu3FU4n
 aXIMNUKanXEJ0piyLfMCthTlCqN8IGFMI2e0RVxB6MwFiVnvilDQQjVBU73VF28yw8T+0aJnrM0
 aJBHhMIZefPI91ABfhs1BvZ0+XZtQ05cq1tuqh26AphMtczKzezV4Q9bwjOWD8XMolzhY9pvGOv
 tAwCBsT0KNuk8uhrSt1yq6Kopx2ZGD34JkgMKNMdjSl7QPs4S5hhH9WyJFdkkH7+6ec9f+B5VoQ
 yXt7RA==
X-Received: by 2002:a17:906:f581:b0:b99:1074:750 with SMTP id
 a640c23a62f3a-b9c679e55d3mr155336466b.39.1775222344640; Fri, 03 Apr 2026
 06:19:04 -0700 (PDT)
MIME-Version: 1.0
References: <20260330141852.984717-1-paul.henrys_ext@softathome.com>
In-Reply-To: <20260330141852.984717-1-paul.henrys_ext@softathome.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 3 Apr 2026 07:18:52 -0600
X-Gm-Features: AQROBzCV6scroSPPOp3-B4-Ho7Azr-vE2yNEjxUcdsRmNFO0dHY-yXzEHZ5FugU
Message-ID: <CAFLszTgfN-+Y7K1ZkQS947BdMBFtPqOLof8tsU7b4JzCKJbBJQ@mail.gmail.com>
Subject: Re: [PATCH 0/1] u_boot_pylib: disable standalone module detection
To: Paul HENRYS <paul.henrys_ext@softathome.com>
Cc: u-boot+nodisclaimer@lists.denx.de, sjg+nodisclaimer@chromium.org
Content-Type: text/plain; charset="UTF-8"
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

Hi Paul,

Can you please send this to the mailing list too?

Regards,
Simon

On Mon, 30 Mar 2026 at 08:19, Paul HENRYS
<paul.henrys_ext@softathome.com> wrote:
>
> Do not try to detect standalone python modules at the top level, so setuptools
> stops searching for: command, terminal, ... as independent modules and instead
> relies on package discovery.
>
> Steps to reproduce the issue without the patch:
>
> git clone https://source.denx.de/u-boot/u-boot.git
> cd u-boot
> python3 -m venv myenv
> source myenv/bin/activate
> pip3 install tools/u_boot_pylib/
> ...
> error: Multiple top-level modules discovered in a flat-layout: ['command', 'terminal', 'test_util', 'tout', 'cros_subprocess', 'tools', 'gitutil'].
>
> Paul HENRYS:
>   tools: u_boot_pylib: disable standalone module detection
>
>  tools/u_boot_pylib/pyproject.toml | 3 +++
>  1 file changed, 3 insertions(+)
>
> --
> 2.43.0
>
