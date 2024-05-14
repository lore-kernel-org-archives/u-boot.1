Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAB71C04FFE
	for <u-boot@archiver.kernel.org>; Tue, 14 May 2024 18:51:03 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0598687915;
	Tue, 14 May 2024 20:51:02 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=gateworks.com header.i=@gateworks.com header.b="qyUgRShM";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DE752878E2; Tue, 14 May 2024 20:51:00 +0200 (CEST)
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com
 [IPv6:2a00:1450:4864:20::635])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id A0C7387915
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 20:50:56 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=gateworks.com
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=tharvey@gateworks.com
Received: by mail-ej1-x635.google.com with SMTP id
 a640c23a62f3a-a59b58fe083so69736966b.0
 for <u-boot@lists.denx.de>; Tue, 14 May 2024 11:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gateworks.com; s=google; t=1715712656; x=1716317456; darn=lists.denx.de;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iaRpIOi2rAxD9Fqh+y7uP585pa5fOxuJHPOhcksZH6s=;
 b=qyUgRShMA4ik93l9ZIriPnsl+AwS9k0OgKoF63lnU2nrU0S5Eop9MghSz/Pkd/PSFh
 Ivuq1lyAw+ggQzbJBH/vLXEMoDS44Yp5y6bW3qrusq8rFwLdXoUqnNreV7jnZfpPmVJ8
 jk/PzSPSQlcQEYj6ORWhEPkXKGdQZWh2mxs2OIRzrQkC0F5T9PJKWvwD0ZK/qhAxTaKp
 ZtN7dl/z/rABy5h9DAsskXvftIZNheaPCICvLrYIpXCmAd1lbUvTIBDS6nrGT2b+6YZT
 K69By+YvDYKdkPTLNp06d5gWOFRuJoDoJxE0FBlccSec1m9Yl2cN+L/JR6UcpSv7Ifme
 7wqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715712656; x=1716317456;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iaRpIOi2rAxD9Fqh+y7uP585pa5fOxuJHPOhcksZH6s=;
 b=h0n6i9mSbRv/bp34WHvrhz55gf3seiz+ww2i84flgU6gPEIOLu9p/L4THN0b1GbO+L
 9gyZPVHI0XXAld55f4uI24daOh5KNyipVM8IbNDbd6jaY/y5PG7kVeEkT+EwJlMJGTZl
 jQK+8975sNBPSmXUfVUPJDQdH01Ph/OpiiQZaKj/uXj63NexO4gnlH4hSrYviCN37lzs
 eJFu6UdUPuVvTwsJWURuE3e50Wt/d0hSMCiR3e8hGaBg+Ufc0JMqbXucvRhX/VHYArvm
 R1fcUrKQDp9Z6fUTEEsswugQtYE/A6gUTjFuO+BVGZvlNuPzV2e07tL+OCRV1iGCgGuE
 7s2g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVoh+ri1ZvasBUfXx+dIWUq4abCWurnORQpo+fbExhS45+ampWWYaW4i4TNa2lea6pPh8sK+zYx9Ne2Lg+HHYJpenrfFg==
X-Gm-Message-State: AOJu0Yw2yGzr58pzK+Q+pQM2KT9EJOGpKVaYJ7Av9bd9/O8VD93nGmiz
 DNfteQQkKqvc/KcoQ7auBhx901KA7IOAx71+4Usn6051eOYRfcpTZeXWPzJ9FOY78fGqIH9oBf/
 8FhZo/Oiqx1ceEeVhC+2hwfVLPc3knubTexaQXTduVfRP/5dSaaY=
X-Google-Smtp-Source: AGHT+IEX4ykhKacumFRyXfggzVvDZNMVopZuDTkgqk6iUVu5c213aC97T0/q2KIA+foszFUdsG3qJS3UBUaeG0Fl+Hw=
X-Received: by 2002:a17:906:7f06:b0:a59:ae57:1660 with SMTP id
 a640c23a62f3a-a5a2d57a756mr739106266b.32.1715712655875; Tue, 14 May 2024
 11:50:55 -0700 (PDT)
MIME-Version: 1.0
References: <20240503010518.263458-1-marex@denx.de>
 <20240507130650.713801-1-ch@denx.de>
 <28173ffa-209b-498f-a2c3-99ec2f898e7c@denx.de>
 <e98dc839-f58f-4463-9358-4d3ba267d558@denx.de>
 <7d834245-9ac2-45cf-b5bb-045560863bcb@denx.de>
In-Reply-To: <7d834245-9ac2-45cf-b5bb-045560863bcb@denx.de>
From: Tim Harvey <tharvey@gateworks.com>
Date: Tue, 14 May 2024 11:50:44 -0700
Message-ID: <CAJ+vNU2MCQNDO1hehq3CvWAFUqaSR=0eW6xRrE8Dzcna79-doA@mail.gmail.com>
Subject: Re: [PATCH] imx: hab: add documentation about the required keys/certs
To: Marek Vasut <marex@denx.de>, Claudius Heine <ch@denx.de>
Cc: Peng Fan <peng.fan@nxp.com>, Fabio Estevam <festevam@denx.de>,
 open list <u-boot@lists.denx.de>, 
 "NXP i.MX U-Boot Team" <uboot-imx@nxp.com>
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

On Sun, May 12, 2024 at 10:08=E2=80=AFPM Marek Vasut <marex@denx.de> wrote:
>
> On 5/8/24 9:23 AM, Claudius Heine wrote:
> > Hi Marek,
>
> Hi,
>
> > On 2024-05-07 3:28 pm, Marek Vasut wrote:
> >> On 5/7/24 3:06 PM, Claudius Heine wrote:
> >>> For CST to find the certificates and keys for signing, some keys and
> >>> certs need to be copied into the u-boot build directory.
> >>
> >> Make sure to CC "NXP i.MX U-Boot Team" , else NXP is not informed. Use
> >> scripts/get_maintainer to get the full list or just reuse the CC list
> >> from patches in this thread.
> >
> > I send the patch with `--to-cmd scripts/get_maintainer.pl`, maybe I
> > should have used `--cc-cmd`, but that would not change the list of
> > recipients.
>
> Should now be fixed in
> [PATCH] ARM: imx: Add doc/imx/ to i.MX MAINTAINERS entry
>
> >>> diff --git a/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
> >>> b/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
> >>> index ce1de659d8..42214df21a 100644
> >>> --- a/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
> >>> +++ b/doc/imx/habv4/guides/mx8m_spl_secure_boot.txt
> >>> @@ -144,6 +144,22 @@ The signing is activated by wrapping SPL and
> >>> fitImage sections into nxp-imx8mcst
> >>>   etype, which is done automatically in
> >>> arch/arm/dts/imx8m{m,n,p,q}-u-boot.dtsi
> >>>   in case CONFIG_IMX_HAB Kconfig symbol is enabled.
> >>> +Per default the HAB keys and certificates need to be located in the
> >>> build
> >>> +directory, this means copying the following files from the HAB keys
> >>> directory
> >>> +flat (e.g. removing the `keys` and `cert` subdirectory) into the
> >>> u-boot build
> >>> +directory for the CST Code Signing Tool to locate them:
> >>
> >> Do symlink(s) work too ?
> >
> > I have not tested it, but I don't see any reason why it would not. I
> > also don't see a reason for mentioning it. I want to keep it simple, if
> > the dev whats to do things differently, they are free to do so.
>
> "
> Per default the HAB keys and certificates need to be located in the
> build directory, this means {+creating a symbolic link or +}copying the
> following...
> "
>
> Please test it and add it in V2 if it works, I think symlink is better
> than bluntly copying files around, esp. for crypto material.

Hi Marek and Claudius,

Yes, this documentation is needed as well but I'm still unclear why
the old method before this series did not require the usr_key.pem
files, why I don't have the *usr_key.pem files in my crts dir created
(long ago) with cst-3.3.1 and cst-3.3.2, and what I need to do to
generate them now that they are apparently needed.

Best Regards,

Tim

>
> >>> +- `crts/SRK_1_2_3_4_table.bin`
> >>> +- `crts/CSF1_1_sha256_4096_65537_v3_usr_crt.pem`
> >>> +- `keys/CSF1_1_sha256_4096_65537_v3_usr_key.pem`
> >>> +- `crts/IMG1_1_sha256_4096_65537_v3_usr_crt.pem`
> >>> +- `keys/IMG1_1_sha256_4096_65537_v3_usr_key.pem`
> >>> +- `keys/key_pass.txt`
> >>> +
> >>> +The paths to the SRK table and the certificates can be modified via
> >>> changes to
> >>> +the nxp_imx8mcst device tree node
> >>
> >> "nodes", plural, there are two, one for SPL and one for fitImage.
> >
> > Well, I was thinking here more generally about the node type and was
> > assuming that the person reading this knows how many they have of that
> > type. But I can add a `s` in v2.
>
> Use "node(s)" which covers both options.
>
> >> It would be good to mention the DT properties which govern the crypto
> >> material paths -- nxp,srk-table, nxp,csf-crt, nxp,img-crt -- somewhere
> >> around this sentence.
> >
> > This is something that should be documented with the changes where that
> > code was added, IMO. I only documented here what I found out and have
> > used myself, I haven't used those.
> >
> > I would be interested in reading how to best overwrite those paths and
> > the image structured from board u-boot.dtsi files myself.
> >
> > If you want to can pickup my patch and integrate it into your series an=
d
> > extend it.
>
> I'll keep it in mind for V3.
