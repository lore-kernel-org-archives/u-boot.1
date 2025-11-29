Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B11A5CFD2F6
	for <u-boot@archiver.kernel.org>; Sat, 29 Nov 2025 21:21:08 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id B8856836C8;
	Sat, 29 Nov 2025 22:21:05 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="L82obe0H";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5C53B836CE; Sat, 29 Nov 2025 22:21:04 +0100 (CET)
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com
 [IPv6:2a00:1450:4864:20::130])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 6786280107
 for <u-boot@lists.denx.de>; Sat, 29 Nov 2025 22:21:02 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=festevam@gmail.com
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5959d9a8eceso1931973e87.3
 for <u-boot@lists.denx.de>; Sat, 29 Nov 2025 13:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764451261; x=1765056061; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QZuBOOPHBlC9cmAj2suGW0dyzlQgka3bBnTAJlsu0Bw=;
 b=L82obe0HqbSSuQvF83/gI6QEb1DLdxFsYhfixMvLY7Wm7PEvux7W7KKsgrclSpBM6+
 eDDpme6rhB7ux/Lys4aq882tABPg7/3j5x9G1v47KJpZJ/DsYMr2TRuYBkwbqtq6EJJb
 v9r09E8N3HsZyMfWzUPh30aE2MC1bBW7NYnCltLxT/1VEyZuOKW5DVuEZo/qkewVFLVV
 aNSO53VJts/r9MB/Jg/grIRjX9qxUb/RlRvHCdmlqgWElU4AyqYb1D4inUhBvzAaQncI
 ysTS8Cn0NlD34SAZxyd30+MLVuoMOXldB6QZ2yeGdSl+YO6489vFfNDcTucjwWjeYDoB
 QaLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764451261; x=1765056061;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=QZuBOOPHBlC9cmAj2suGW0dyzlQgka3bBnTAJlsu0Bw=;
 b=rGqPoIzsJ82M9aRPv+pz5y8n9bGZgp8rTJfut6FYhHDT9kNv5ECRsL3M0zDLPQsME7
 7Mr4YPHphdwzEyMnNsiTLNhHPZ9wXd2YZw1NNzDhp/gYfOoyLmUtmoi4TvzqZbyJJ9d8
 gtN4Z6bNwVEiOPs0iBUl35o82VaFDFRpZ3gPCzZZ1sS624v2kM1Aofy/jkw4Ucd/I4pt
 9N3+56ZvZfePbCjMkDFyMUujxpVcQZH+NvjYjxFZC7fYR5F6bwv/utmpH9bOoygyolT2
 QEisB6fl/HPRMTrUUpT7c+PCRn1PM8Qgd3KMz8+UCFyeOI4k0khpg9D34CBOL3leMnpj
 eEiw==
X-Gm-Message-State: AOJu0YxO70T+OEYjeSHk6/UKiuemwqx781oIS9Uk2cWs1nhNS1tZzzrY
 CmIesmsVNs7P6e4OtKeFigWZYfZCp9pXsPr7DTtbn0/OKh360X3bEGC2Toet0nn0pYF/dycJtBS
 PSC2CHJWTCK/Qw6lYzu4ucvuq7i7GTdY=
X-Gm-Gg: ASbGncvV1l3B8boFx2d58ZJQbfPdzZdauUqb37P5VgFcO5HXuj8W3L0O0/brXXHCUzb
 fmA+jORCpVN75ZUCKtZcHEhCxPpYTOA4rMyNUNZ0ahVop9bbSsR05nO5xmomIbJkUPyTTHj/Hi4
 sGvKbSFaoK73Y/mCV8SpN7vdLbOu+Sygq4gTIbe/fGi9fm/EXj9YTdb7JyMVA6KESwLbBX4SPWV
 r5PC4zdsbeLpkBKuFen4cQG+KFfE+vJZjRoasPoWTeud9FmxrqlK4XlbKzNi7AtXmhP2YlVNOhW
 Sv8BfkqCsJoRTt8ykxa/Tbwl8S8=
X-Google-Smtp-Source: AGHT+IEzGLuj1mHPuAqFuM/TZ8geRmCwXkW9WoJHG7tOHon+6RMIJd3GsaPGHBiABUzv9VgREpF6B52Fqjc7fFVvQ00=
X-Received: by 2002:a05:6512:b05:b0:595:7fa2:acf with SMTP id
 2adb3069b0e04-596a3ec5f2dmr11166663e87.31.1764451261324; Sat, 29 Nov 2025
 13:21:01 -0800 (PST)
MIME-Version: 1.0
References: <20251128-wip-bhahn-imx8_cleanup_env-v2-0-93ebfd1591c7@phytec.de>
In-Reply-To: <20251128-wip-bhahn-imx8_cleanup_env-v2-0-93ebfd1591c7@phytec.de>
From: Fabio Estevam <festevam@gmail.com>
Date: Sat, 29 Nov 2025 18:20:49 -0300
X-Gm-Features: AWmQ_blepaNjlyJ3ql2IN3DhgfdfCaRtb53TdMsClQYT4w9kfLsy9_EufbubajQ
Message-ID: <CAOMZO5DrgvFkedQacxXPWtnT6vKE8pXAp20hz_goSJP919z5cA@mail.gmail.com>
Subject: Re: [PATCH v2 0/6] phytec: imx8: cleanup environments
To: Benjamin Hahn <B.Hahn@phytec.de>
Cc: u-boot@lists.denx.de, upstream@lists.phytec.de, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>, Teresa Remmet <t.remmet@phytec.de>,
 Tom Rini <trini@konsulko.com>, 
 Peng Fan <peng.fan@nxp.com>, Leonard Anderweit <l.anderweit@phytec.de>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Martin Schwan <m.schwan@phytec.de>, 
 Yannic Moog <y.moog@phytec.de>, Simon Glass <sjg@chromium.org>,
 Yunus Bas <y.bas@phytec.de>, Stefano Babic <sbabic@nabladev.com>
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

On Fri, Nov 28, 2025 at 1:39=E2=80=AFPM Benjamin Hahn <B.Hahn@phytec.de> wr=
ote:
>
> The state of the environments are different for imx8 boards. Some boards
> have more and some have less features. Cleanup the environment and bring
> all phytec imx8 boards to the same level. This includes:
> - remove unused variables
> - modify variables for use with ampliphy-boot bootscripts
> - set bootdevices, bootmeths in devicetree for standardboot
> - modify boot_devices dynamically for sdcard boot
> - let standardboot set bootcmd
> - sort env variables alphabetically
>
> Signed-off-by: Benjamin Hahn <B.Hahn@phytec.de>

Series applied to u-boot-imx/next, thanks.
