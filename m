Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 409B8C982E6
	for <u-boot@archiver.kernel.org>; Mon, 21 Sep 2026 14:27:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E9EA96065E;
	Mon, 21 Sep 2026 14:27:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lEcfxdC_4e9W; Mon, 21 Sep 2026 14:27:47 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org DEA7E605E8
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790000867;
	b=mCJgQAKS6nFwTHXFN5P7W9fFgPw+rF3BAAhH7sCNzs2e+p8WY9ZBg9Uf98e2InlmCrYQ
	 v40/AAO7z3FpZ9449hRdzYAENOQXtNwsVO4ku3bawrHpF5HG0tbsskVG18dVyp5U+TcKj
	 yNZz7pvKn3WkgQ1OvDxarhzAWQiXHkeCflz77kTc4Q7+ILNK4bgQWPbIy4WUDbNWz/5R0
	 +CMz2NSYFrm3TjBYBg9R8npEy3iSeRAdAkkYBEMBjB5e0/SCzxAAFi3DPTAqO71QUBnRL
	 aefAEPt9irVVjJun0b2yPCtbyt+nlDBbEfwiGxF9i6ni6DuvKReR2liWl3G83Ks0Uaw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790000867;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=Iu5BaQgTIZt04LUA8ipkcvOIaBmlfhZiK+z53M6fDK4=;
	b=qA0BtmOtSEwUlFWWMOrD9YLyr4AoSgdqinK7GdfESCp/kGXffJxwUZg7T5jjTrWUBwmd
	 toMmkW5IH9jfaIhUxDHM8Pj50KL7hjKwSFyrLOlDu2KJ/SxQ5vgSIG2Ch06swnhE1JybS
	 jUDDF9v1+WrnIDlvoCWWwqrdGBNKvM3rkLZ3IEMw+6FKx647J53y2kPx0E/TerEH42uvU
	 auJkOBMe7za5LzmjDDAtQm3xQzJjkICWG8yZHV8lcixh0M9Tcch4ttvL4uzWeZwsflGdD
	 1LmBic54zbk2l5wSch5oC3d1S48QafPzQxOjWOJYuX4pTkG8ofScQnx/VEKeyvUjzSw==
ARC-Authentication-Results: i=3; smtp3.osuosl.org; dmarc=pass header.from=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=zT3Hu0Im;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790000867;
	bh=Iu5BaQgTIZt04LUA8ipkcvOIaBmlfhZiK+z53M6fDK4=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=mTQBr8tvp9ES7NJECUJ7cwwtN/DXEfHvcIFZazdK4WVEIVbrH71Pk/jyFYz7XSPzk
	 vM0DEf5eYtQvjRMoZY7gZwnSEQ4x07Jl8Aha0syQI/OWFTaZqeyyreoUMWnGweUS+q
	 vFYq4J8PFVF+R3BlePMkwSDv+qVLDKulL7bdE0J6xJzuJVyBjrv6qx0x1XdaG5Brhz
	 T3WnmMVeCAke2GkUyVBCljeAu/DdQ5NN2GcxqtRHmQia++xFrco6ouKtsHzZAoz0d6
	 hN1GqcnoY8ak8d8rb3YWEzfFSAexVDkMp5zasAUZkYsRUmVdUDhwBXAutYWu9s9kAA
	 wBiB/1hRX+NGQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id DEA7E605E8;
	Mon, 21 Sep 2026 14:27:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 96C3824D
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 14:27:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7D280605E8
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 14:27:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IeUDWJpw4inD for <u-boot@lists.u-boot-project.org>;
 Mon, 21 Sep 2026 14:27:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 4E14C605DB
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:34::f"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790000864;
 b=nmpxBafvzb+wdNgOnN1lsztINTIIMVIY75R/zsw31aGAyDiaxlNUz6wSQfPm0b+3HF4w
 U89+d+TC6nDpVCiT8ZHU3SZdQZusgvN0D0s4IU5TNFE+PF1dGageE0cnp9rTZx7DMKGRI
 wxx5LiwdO7YGweTdTIzBW5HLPKUPypx2jFZNHUWX2WIzdypBTZ1CDPf/5/LKr9jeQ9uNh
 zyQ6l+7OhP5NkLPtcsiMX1Rmn16ZpsoVwlN+A+xTkf63jEl6LUMIwS5sbYd9MffBGsN5m
 aAjVloGuCr9qrTCsomwTNGSL/4lioaG7fWK3skV+dTTlK5eWmqARSO+CGJDWvqT7nOg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790000864;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=Iu5BaQgTIZt04LUA8ipkcvOIaBmlfhZiK+z53M6fDK4=;
 b=S+sRXtdspKqssE/OTHtVp5IifOhHYYFX+dXECmSES1+q4d+iCnz/p/FrYa+WMV6IajXi
 ERygNMTSK3K6eShZhFNb5R1CeQewhZo3MVHj/xnB+sZvjS2BZNiLi0tk8vH5vHuCNiIBy
 vUuxaoRNe14knyu6E1dz4c7gXY6Pa+doXWl6rK9sqmvI/yhSYPbTXj1ObTPCiNXdWqWbj
 sg8THtb1GtmqqZKdta4d7L8Vv7eM8hDbK41OzvqhQMTJmeuFA9Q2ej2HuY5NHX/2TM2LM
 M/HkIk5rXAjV+lv1LKFcBxHzDfbwQbK6WdaOlMqLnOMG7ATm4iEN9/v1M7paGo0RmQA==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=flipper.net; 
 dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=zT3Hu0Im; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:34::f"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:34::f;
 helo=mail-ej2-x0f.google.com; envelope-from=alchark@flipper.net;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=flipper.net
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256
 header.s=google header.b=zT3Hu0Im
Received: from mail-ej2-x0f.google.com (mail-ej2-x0f.google.com
 [IPv6:2a00:1450:4864:34::f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4E14C605DB
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 14:27:44 +0000 (UTC)
Received: by mail-ej2-x0f.google.com with SMTP id
 a640c23a62f3a-c254f9f0b20so464059566b.3
 for <u-boot@lists.u-boot-project.org>; Mon, 21 Sep 2026 07:27:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790000862; cv=none;
 d=google.com; s=arc-20260327;
 b=I9N4LsE4MQdAD81qADgQLgIV3+vTZDMJDEeBqBHQM8xK7gfrv/7B49WZcuU86+HXC3
 IAu2Y1wyDAMc+1yabmoeKUBRE/RM1TuVVTWXxStiyAECDXlbKt8tZazlDqlsP0t6pD6F
 9pecsHqZ+lEjv/Ml2dzuxZz2U/VNdursXltVtzlfT6GMdcCpsVOxqnat7gIRp5vpIOJS
 zIPBs3Xw+1wNIivJF4YbKc8F5Yv8uN7bpa3zKWC7steR7vrwcTDOlJPyWRJh47VQNaGc
 CEVNkGvXIVFchULlWbn7/Rtcdt1owTQsFvIuRLFbSDiOHcoxjBPK9GVXsKQsz2rFHhwr
 YT/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Iu5BaQgTIZt04LUA8ipkcvOIaBmlfhZiK+z53M6fDK4=;
 fh=k9kY7a1Wi14n0cNiG9IiAoGAT2s4BttBHc0XPc+Ktys=;
 b=rC0OdD2uYjjkB4S1x8wyq33gJEzYX5dbz9/Pwm2ko0UeAaDXbBn0tIs/l88O0GNlKC
 S18mUZB1Nc4IHD2aTb1evi33GymJojpc/Nh/rA28srhR0kW7iivpYrgY9ab13MKYC0ut
 11zpaYsl8EFMj5A4krYSSb9aBMGNFaEsh7+UQtO33cIhKQTi7jhjQD8P9uxve1jNnTMH
 KPXyGI1tbfHDZghP7Q0UtLeMJ8tfOMc/uDBjwMl7rwwBYaI4AiOD0ekLluo6c5qJT9tf
 VRYvkOhPfzl2mKLR1WueZhSj/Tqj7Pz/VLjtS8MOg2qij/6HHefi0+0FeFas71tqDAtM
 B29w==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=flipper.net; s=google; t=1790000862; x=1790605662;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Iu5BaQgTIZt04LUA8ipkcvOIaBmlfhZiK+z53M6fDK4=;
 b=zT3Hu0Im9Mo549HJ0LYGgQ/h9ZTvCSAbq0AcS2GHT+Gj36bssnmR4ovUpHDOHQVdiX
 UekvonykKU4MMaU2cv8JFMAFz5T1rme49WysbY8xVdW9a4NY9Pk/B1iEaAZBRF/kORGa
 T1KOR1/83UZQl56cGEU5uN+NsAGpZA2RJRq1U16k8JQpwpb50b26D2+U4nI3xjXlX6+R
 AKwaDPg+f19xX2h3UYzr2YnEYeTrK1XgksCLYQ1UVO8SZfZ9Nmf3aQIs3OwThKYNb0Ar
 9efomHz4ADrZL2jnL+8U4tcPxqIqtOOGYHWXLZqW9mfabnF7M+nxHGkDkAPO4lMSO/CO
 UzOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790000862; x=1790605662;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Iu5BaQgTIZt04LUA8ipkcvOIaBmlfhZiK+z53M6fDK4=;
 b=RSwM6tBNMb7YSGuHsi3+ZTl1kN2ypw1WOOVXsSU0lRETKb/bCvM84rFBU4dJ8eICMW
 PF2NNq2IcQCHylVukVCbXSyXWlUmgtzbwINjjjId+jkvawqJU35AXCOZ3+J8M/TeDQJo
 VgGzF82t09OqwGajBLNekd59ZjMxks9gNkE2cobdwGSGILygtDRjzuv/JfQz9eT1xugf
 KkhOOF6Z4QtkVBbbfjGYZ6WHCY0g/bctChuhWkLNfMQ/peqakpsoDhKGg/tq2Lkn+lGr
 Pp0N7Mc3Sp/rveUE54ShQ6pHG8RHNDJGRkT+YGlL9CsOjvmcF4zZSlqubJYizhSTLq1X
 nPDA==
X-Gm-Message-State: AFuF++mSE3eqwnfftjnBc3EwfQXzCyu59GPSRGW4nu147KvRQtshJ4iX
 3BH0+7xq1+r9UH7dzUSi+T08wCJmJMX6Jqqmy3fBN7ZRxCklzJrDUm8DdFd6s2Z/qCW6XpyCmj2
 W5LPZIj2S4xYevvd7J8sYPp1UzpC23NcpRJoDnc4LCA==
X-Gm-Gg: AYBFou14M0v2Z8G2g/TgUKkt0b/NFUMm3VC9XgajGQgaGwMFfrT+JsuLi/pVfmWKFos
 y6Yo2ARHkazVNG7JZJ+jCQQ8A4OxAjCIKuEBorZnYarnphLAL2z96nzgyn2d87rS3wUwhseyKed
 WLOguV83slfHcl0XDPCC70nzeLtx00gQW6cWW0ek43d1jvnEwuhP1yOHYo3QVhYcHBR1sUNhasn
 dqu9ifNkSVQx0fKd/rTSBJw0mHO2fYJfaW8vGaXc+HDhTohh3aznPPXdTdfMCrhb1LRqRO3r6Rd
 rKeu594ouhdUoDP8pRC8bXdiuZan1nYmlRAYklT62zuAPToDl4gfPXmnFw==
X-Received: by 2002:a17:907:dac:b0:c29:f5d8:9c75 with SMTP id
 a640c23a62f3a-c2a15834020mr922818666b.36.1790000861982; Mon, 21 Sep 2026
 07:27:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260918-spl-fit-compression-v2-0-28e946f57357@flipper.net>
 <30490adf-01dc-492f-aaf8-e280bc526a24@cherry.de>
In-Reply-To: <30490adf-01dc-492f-aaf8-e280bc526a24@cherry.de>
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 21 Sep 2026 17:27:29 +0300
X-Gm-Features: AcwNN1Uxr9wplKDnOgzYklRwb-IoRzGUSsGK8jnONkR5vvcXt-TYTFL-FFgtl-g
Message-ID: <CAKTNdwFVtH0-p9LmeXzFkUXi_uQ6f64om3rKCguMK5M_GHg=dA@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] spl: fit: Generalize compression support
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Vincent Jardin <vjardin@free.fr>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Srba <Michael.Srba@seznam.cz>, 
 Cole Munz <Munzzyy1@proton.me>, Richard Genoud <richard.genoud@bootlin.com>, 
 Daniel Golle <daniel@makrotopia.org>, Simon Glass <sjg@chromium.org>, 
 Francesco Valla <francesco@valla.it>, Anton Ivanov <anton@binarly.io>, 
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 James Hilliard <james.hilliard1@gmail.com>, Quentin Schulz <u-boot@0leil.net>, 
 Kever Yang <kever.yang@rock-chips.com>, Johan Jonker <jbx6244@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>,
 Miquel Raynal <miquel.raynal@bootlin.com>, 
 =?UTF-8?Q?Jo=C3=A3o_Marcos_Costa?= <joaomarcos.costa@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

Hi Quentin,

On Mon, Sep 21, 2026 at 5:14=E2=80=AFPM Quentin Schulz <quentin.schulz@cher=
ry.de> wrote:
>
> Hi Alexey,
>
> On 9/18/26 12:52 PM, Alexey Charkov wrote:
> > SPL knows about multiple compression algorithms, but only two are
> > hand-rolled into the simple FIT loading code, in spite of a nice ready
> > made helper already being available right there.
> >
> > Generalize the compressed FIT handling code to accept any compression
> > algorithm compiled into the SPL, and fix up the SPL_ZSTD linkage which
> > requires xxhash in the SPL but which was absent to date.
> >
> > While here, also extend binman to support passing a compression level v=
ia
> > its image templates, which helps squeeze additional ~15% size savings i=
n
> > my testing with Zstd level 19 without impacting decompression speed.
> >
> > This is done with Rockchip RK3576 in mind, so a small Rockchip image
> > template refactor is included.
> >
> > CI passes all green: https://git.u-boot-project.org/u-boot/contributors=
/alchark/u-boot/-/pipelines/1319
> >
>
> Doesn't work on my PX30 Ringneck for any of the supported compression
> algorithms (didn't check lzma as I'm daily driving Fedora and it doesn't
> have lzma_alone binary).
>
> Doesn't work on my RK3399 Puma as well (couldn't check zstd, SPL was too
> big and overlapped with U-Boot FIT, note that Puma is special in that it
> only allows (256-32)KiB for SPL, due to backward compatibility with
> older versions of U-Boot that had U-Boot FIT located at offset 256KiB).

That's interesting. Does it work without my series though? With Gzip.

If it doesn't, the first thing I'd check is overlapping memory regions
for the compressed data and the ultimate load address of any of the
binaries involved.

Would you mind sharing your resulting FIT structure that binman
produced for the failing boards, including all the ATF segments?

If it does work without my series, it would be great to try and bisect
which patch breaks it. Not that there are many candidates besides
patch 5, but I don't really see how it would break things, yet.

> On RK3588 Jaguar, all worked (still didn't check lzma due to reasons
> listed above).

At least something! Thanks :)

Best regards,
Alexey
