Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 297B9CAC5A8
	for <u-boot@archiver.kernel.org>; Mon, 22 Sep 2025 14:20:30 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 98DC183211;
	Mon, 22 Sep 2025 16:20:28 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ECAKIyWE";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 22B6B83445; Mon, 22 Sep 2025 16:20:27 +0200 (CEST)
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com
 [IPv6:2a00:1450:4864:20::12a])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3831082CF4
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 16:20:25 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-57e36125e8aso1081885e87.2
 for <u-boot@lists.denx.de>; Mon, 22 Sep 2025 07:20:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1758550824; x=1759155624; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iQcrgZkWR6zZEnB1F2iSQbsuz4sdn9kdNDpVCDmBkYw=;
 b=ECAKIyWERhrni+QZzyT6hZs2YZ0YZk5RmZwDObNP7rs3aVjBIhdNEfivyX5kMayrUT
 X4p/BKq1wsPhE2sCPB5KaZbO+j6uSoqVpVJ6kE9ES25rX9+dUkwNouOMYl5bZDeazyCy
 kYVSps67F1t7eN383jaUoKS9+BKQSFbe+xUOZgbxNv0HXNuFObfmXGlG5HbTY2lEOoEV
 QuG/RQ0zWUAp83ISLIppz5/RerlIxrif7yNfBdxFOvmtoW1shqBHWVB6Pu3x2cNmDYfu
 wI4F0eYA2j1Jrh94AcEfsS4dtzfs8hR0t2krU5/kQIZmhRmL23pjM0YSkndvZgYruqdE
 DASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758550824; x=1759155624;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iQcrgZkWR6zZEnB1F2iSQbsuz4sdn9kdNDpVCDmBkYw=;
 b=Cu/ti5TTWjlvV8IRJdzvr48EE6jDb+RXI+7//B3pzimiCiz5ahGEpF3tUqRpcPl3W/
 WbdeOEZDs4pPUg1zDjR3bEcIXIcfTDXGH1uY9EDzdiQKQ5lf3m54xnKBcgcGSbHP1FUP
 11oKlpHBD+YX8T+MePxUvDXsYqVj8daPmGfLwaBH9NgXJJj3EDBUibc45tV0P9b+OSrY
 YfDqn1bXixKOnk1u8f6ljIWtFRkqn5RPH+xluzKkFdQJkDFyUqpvzsQykFTRWbIpD1Gh
 S510ZQO/3F7MmxE9gm8s5B+cMzpKqQNeWr2DbIuBLfGlnZYTR76JqKd95lHpgIsAxqhz
 zfYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAe8n62zL9qeD9RKFMvqM/qX8FiN6xx6ERKkstnu9YotcXgsdEnv2Ic1OsI8O1sAOzxuNqrlc=@lists.denx.de
X-Gm-Message-State: AOJu0Yy0AlMnfur96lW2aqXu8PuBLajruzYnVLsatD+GsgFdvhgOJkW9
 robgyetuVvF5WWy87nLDly4ZrP25e8Yruh3sKJnMOS5s0nRJL8wJrqofDnOynto4nvUKtJ9aLI/
 HEHUX7c+GOO5N6NeXmRjOZ4pKPjL1hBk=
X-Gm-Gg: ASbGncute848OvyN2d4Ia6QYNIxhpd11EZ3rWCYKUWQl4thlkQpbeWD8Byz7Vx7Gmfa
 SY+jE/ltAaHQKZsIa/7Q7xQtJyhucf/T5xn/3ZdnWZB63KBbzhhsfAep0cd75+PcT19unYG8Xnz
 /SdEQyNohw1LEwBoZpnHYi1kBO0SY+5AjLLvXlqnvQ5VOcTjPcFA+9fw31vstAxXhxSSR6fsIEz
 Rj9y0stxEhPDuG1dyvO/Dr7kQUcx5x/jRK8wUE=
X-Google-Smtp-Source: AGHT+IHnhiKh1UO/dnuuFsKqEJpBzJSvz/eIjH6jArQRyBpMkJ1IRHj8nIDiPta1I4mi4pe6ML7EZqopKhF0aC8r108=
X-Received: by 2002:a05:6512:6811:b0:57a:33ff:c7fc with SMTP id
 2adb3069b0e04-57a33ffc8f6mr3457876e87.48.1758550824320; Mon, 22 Sep 2025
 07:20:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250818043344.GB13772@nxa18884-linux.ap.freescale.net>
 <20250908211838.3772709-1-john.ripple@keysight.com>
In-Reply-To: <20250908211838.3772709-1-john.ripple@keysight.com>
From: Fabio Estevam <festevam@gmail.com>
Date: Mon, 22 Sep 2025 11:20:12 -0300
X-Gm-Features: AS18NWAbytla39HMVuCPpetuC1DVLCf7TrBTBNXf9jsPulVLwsIx3LslJS-hSYw
Message-ID: <CAOMZO5C-hxz-+4=50pGLtO0Ma4wtaHQFfpGqJJDH9nYC=b8=jQ@mail.gmail.com>
Subject: Re: [PATCH v3] imx8: Add ahab_commit command
To: John Ripple <john.ripple@keysight.com>
Cc: peng.fan@oss.nxp.com, alexander.sverdlin@siemens.com, 
 andrej.valek@siemens.com, hs@denx.de, peng.fan@nxp.com, sbabic@nabladev.com, 
 sr@denx.de, trini@konsulko.com, u-boot@lists.denx.de, uboot-imx@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Mon, Sep 8, 2025 at 6:18=E2=80=AFPM John Ripple <john.ripple@keysight.co=
m> wrote:
>
> The ahab_commit command allows the user to commit into the SECO fuses
> that control the SRK key revocation information. This is used to Revoke
> compromised SRK keys.
>
> To use ahab_commit, the boot container must be built with an SRK
> revocation bit mask that is not 0x0. For the SPSDK provided by NXP, this
> means setting the 'srk_revoke_mask' option in the config file used to
> sign the boot container. The 'ahab_commit 0x10' can then be used to commi=
t
> the SRK revocation information into the SECO fuses.
>
> Signed-off-by: John Ripple <john.ripple@keysight.com>

Applied to next, thanks.
