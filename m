Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B73DC61DCB
	for <u-boot@archiver.kernel.org>; Fri, 28 Aug 2026 14:59:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EF54D40861;
	Fri, 28 Aug 2026 14:59:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id b9o-mZ9Jkakm; Fri, 28 Aug 2026 14:59:18 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787929158;
	bh=//Jx2F616wZS65vJAiCv9mcE9tGS4WtaYcLYQ+wgI+M=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=HdtIqAVtrl5D4aq+O5ci1MXzp8TDuC/1VOe7XSON3XP7dEj/qC7kiM1yAfbTmh+Y7
	 opC93k/0A4kYCBSBka+W5hAHxjauR909D2sYIjzhG2QA8UxJqVaRs7Id8LPiGdUdmW
	 CcNan5MgDfMAWhYB3wTwkWsqAURPEm4LewwSZCPUjYUBh3VuIpjdmWs/MUCuWgGKIi
	 2NoNFBi7gxx2vi7Q8IC0GE7s5Dq8p+Q1kKSdjLexqwtsZpS9mdvaKZtEQdiLPjp91j
	 oX5qwYiqz5c9KU/5a69VlW+tyDL8aEEPq3iTeCSemtaByG8RAxP8nNNDeQQM5Cs86O
	 9bx9ZVMLB65iw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id EC78F40845;
	Fri, 28 Aug 2026 14:59:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id DAF92127
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 14:59:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D8E49403A6
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 14:59:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id di36BU66TvXQ for <u-boot@lists.u-boot-project.org>;
 Fri, 28 Aug 2026 14:59:16 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::32a; helo=mail-ot1-x32a.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=hjGAMiqR
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com
 [IPv6:2607:f8b0:4864:20::32a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0DEC640177
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 14:59:15 +0000 (UTC)
Received: by mail-ot1-x32a.google.com with SMTP id
 46e09a7af769-7f4e1568932so1388175a34.2
 for <u-boot@lists.u-boot-project.org>; Fri, 28 Aug 2026 07:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787929154; x=1788533954;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=//Jx2F616wZS65vJAiCv9mcE9tGS4WtaYcLYQ+wgI+M=;
 b=hjGAMiqRf9Nb5cji85e3M42tcLti74p2nEvIUlh+jWPtmyW+2ux5IX3VKW+RROC5/h
 yeAynpnThsQWN41sic3wqQfMNCgcUGOZaBqEovlqkIeLj1w6ZnqXFyo5JlqOPAOOsg8T
 WxgvddpxjKU2BQ4f1vdaTNjJaKQ4nxXoSLhgg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787929154; x=1788533954;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=//Jx2F616wZS65vJAiCv9mcE9tGS4WtaYcLYQ+wgI+M=;
 b=n7/NRvSILjXhQrNJtlRvHA7VPV+jipXFgth972YD6D+8E6FE8g83hizFvJ1/4O34HJ
 IAo2pW7l8aWAjNATSHvvy4DFMlleZCfywI5YtVxzCUKXE48i7T+PDv6UtzRrNGnNg8gy
 PXB+1giJtmUT3wHbDxpf7tNIbv+qucXYbOj0JxskazN46Ak8Y5NzTK4kyMo4IXg8km9T
 bJNdbQLaY9x3dR1vcOcWv6v3SBHSV+foPtFV+cacKyc54UmCUs5ucpEvd4Wh4AkDxxR7
 tRGU8XrUywsTqu6pp+MPjtHuYu1K3OmrK7fv99EWJ//RQY+T99a1XAIEFiKteulRxViC
 4Rug==
X-Forwarded-Encrypted: i=1;
 AHgh+RoECcwpb+iaWQ91XB1Ar728eLQt7UUWSCO95ZNhZwsD0ru5tmYOAw5j+KQ3YSbpeE45n+IyaXg=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++nIz7z6mHtTZ70WV9t2G9/2Kp0Y5J7qeGMdNU1YOWxBQEz097DR
 BsJxtcb9QjWwuZqg2GADevHSJFinJWdNhWAdTiQuhXJZk/dwALVDYhM4x7nVPKFq+4Y=
X-Gm-Gg: AR+sD11vQjkBhWx2UAUl4exGajHiPV4jTeSPrwTLkHR21vYXKJpzGMSTGjisJBecNUn
 kYXrecXKnD/S794CX2t6qZQ+e/Pp2v/9cog6HWJoDtDmwN9xyjPUs7UiDIi6fpbJikZGUCuGU4l
 GiYOPNxAIQHzR150Ey3ep3QJulT81HnOXJF2otqh8OBfL2yHahtmP/7MhCt0W3ygyLbUrh+dfgr
 vSmqkwnrPSa8tWNc+9c7JUZHewgGqtH5nUPblPCsdnGwDVzklEHvZ6+gwGmhKEC+Ph2XVJC45gM
 Ut5BpZT3KN0SBfKH6ZJWYnCuYDZue11Y6WH+oq0Mxqfh1DaXYr8wFc8CPXX0yaglpjXyQ2lzlTv
 fPQ/53hnltJysmozvxppvrWhCsFBKOhHle5o//MxnXaf0vuXWLrxMDpzsXw54f/Q5+UgYz0nmNh
 lFWxFg54KKnIjDWbpwbJdedE2KuIpLu0xqanbjc0lNpD0hyBfZTOFMPSa3ti4bBpu6nxVwX7kxg
 kLAWISlXzyMj4PRQNlJ28pvPU3Uu2GrXjVC8e47RgHdKuEOHbSIUDx9Qg0dWTWmBR1HAMb3wYy1
 PF8yu2nlSQ==
X-Received: by 2002:a05:6830:3745:b0:7f4:d59a:1c62 with SMTP id
 46e09a7af769-7f4f2640b92mr9976583a34.11.1787929154338; 
 Fri, 28 Aug 2026 07:59:14 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7f4fa6bc42fsm1383322a34.6.2026.08.28.07.59.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 07:59:13 -0700 (PDT)
Date: Fri, 28 Aug 2026 08:59:11 -0600
From: Tom Rini <trini@konsulko.com>
To: Carlo Caione <ccaione@baylibre.com>
Cc: GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 u-boot@lists.u-boot-project.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>,
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 David Lechner <dlechner@baylibre.com>,
 Julien Stephan <jstephan@baylibre.com>, Johan Jonker <jbx6244@gmail.com>,
 Macpaul Lin <macpaul.lin@mediatek.com>,
 Chris-QJ Chen <chris-qj.chen@mediatek.com>,
 Pablo Sun =?utf-8?B?KOWtq+avk+e/lCk=?= <pablo.sun@mediatek.com>
Subject: Re: [PATCH 0/3] Add RITY devicetree preparation support
Message-ID: <20260828145911.GH3959812@bill-the-cat>
References: <20260828-ccaione-upstream-mtk-fdt-prepare-v1-0-bf80b489eb0f@baylibre.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="8GVXVqsVthmqKCXU"
Content-Disposition: inline
In-Reply-To: <20260828-ccaione-upstream-mtk-fdt-prepare-v1-0-bf80b489eb0f@baylibre.com>
X-Clacks-Overhead: GNU Terry Pratchett
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


--8GVXVqsVthmqKCXU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 28, 2026 at 10:39:55AM +0200, Carlo Caione wrote:
> RITY images select a base devicetree and an ordered list of overlays
> through the storage, storage_dev, dtb_path, boot_dtb, fdtfile and list_dt=
bo
> environment variables. EFI boot needs the selected tree to be assembled
> and published through fdt_addr before the operating system is started.
>=20
> Add MediaTek support to consume that interface. It locates the selected
> source on GPT block partitions or on the RITY UBI/UBIFS NOR layout, loads
> the base DTB, applies list_dtbo in order and publishes the completed tree.
> Both raw and authenticated DTB and DTBO inputs are supported.
>=20
> Expose mtk_fdt_prepare for interactive use. Retain the dtbprobe and
> fdtprobe command names and positional arguments used by RITY EFI boot
> environments. Also provide bootembedded for legacy boot. It locates and
> runs the appended RITY boot script through the standard source command,
> leaving the legacy policy and authentication to source and bootm.
>=20
> The implementation uses existing block, MTD, UBI/UBIFS, libfdt overlay,
> image verification, source and bootm services.
>=20
> Signed-off-by: Carlo Caione <ccaione@baylibre.com>
> ---
> Carlo Caione (3):
>       arm: mediatek: add RITY devicetree preparation
>       arm: mediatek: add RITY devicetree compatibility commands
>       arm: mediatek: add bootembedded compatibility command
>=20
>  arch/arm/mach-mediatek/Kconfig            |  45 +++
>  arch/arm/mach-mediatek/Makefile           |   3 +
>  arch/arm/mach-mediatek/cmd_bootembedded.c |  59 ++++
>  arch/arm/mach-mediatek/cmd_fdt_prepare.c  |  66 ++++
>  arch/arm/mach-mediatek/fdt_prepare.c      | 502 ++++++++++++++++++++++++=
++++++
>  arch/arm/mach-mediatek/fdt_prepare.h      |  10 +

Is this some mediatek specific format? But even if so, cmds should go
under something like cmd/mediatek (and get docs..).

--=20
Tom

--8GVXVqsVthmqKCXU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCapGiNwAKCRAr4qD1Cr/k
CvBYAP4mIqwqu81gyd3hD1z5FLGe+qWQQU+X0d6iv3pkSYi+6wEAjBNC5aAya3IM
SWvecPZzrTP6AeWjIjWmkxE7v5e0CAY=
=IGn5
-----END PGP SIGNATURE-----

--8GVXVqsVthmqKCXU--
