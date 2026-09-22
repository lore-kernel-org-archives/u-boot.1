Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B288FC982FA
	for <u-boot@archiver.kernel.org>; Tue, 22 Sep 2026 15:24:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 77EBE406FA;
	Tue, 22 Sep 2026 15:24:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yXslzf2tRFIm; Tue, 22 Sep 2026 15:24:08 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org C53BC40709
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790090647;
	b=YUhfL5Y8/tjYZ0+IReEaALX55IQhoYqIF2bCjed0QkO/mKPP/Wh3uVrZ5v25ruLeIu08
	 M/lzbfRY4BNvsEr8F7Og9DZOphA7YcRGT/nv6dD6+lxqKWZMdxc68jhVlVrOCEl4iM6Gl
	 oeTB4uttTX8geGkQPXit0f/AvGv0ChQvoVbYxsoNnM7/iDnyuiFn+jtlaPHJH7so8uEbe
	 5fV2gt2eEES+BtxpF16V82CLvBGRpQ8KqDXyaZRlrKnpuy2j4LxsggVFVv+0d+8wjbTxU
	 JV0RNp60Cxc6Ku+1QxvuPul/H0NiP44U+qTTAmzOUGJDAZYRct/50D8THYEduJR3/7w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790090647;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Clacks-Overhead:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=9LFvedRM53ige81gxUCW24TjlYV06LqOWCfLF5PNjFI=;
	b=ERnwzDh7Mk6gJbp4SorTugwe1tvBeDoXv91w9Cuu0ZnAalF9FkV9sHp+o8Pf23g0HeYj
	 wc6qOFjuoTLgQE33DJFwPb8FFSee86JTgdn7DzJq/0bqZVdg/fZhzY438RWD7hO98qX1l
	 6fQ816B86vZiqgJShUAEWdfLcBz0ekQQS2gjE/h0KhM/vchItKDNMMByij4NHDRtB+TXZ
	 ItIoHqgGmbV/bYF0O2aj4ssbLXWtIhvPbdAg+p9Xj2xVblgsoXVcrWFNYQMplk01YFKh4
	 t3ssKZ7w57KFwd4E6agH+mnw5ETYjNe53HO2AAfCGfE3UekXb1u1Fh4McdFvPE1PSZw==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790090647;
	bh=9LFvedRM53ige81gxUCW24TjlYV06LqOWCfLF5PNjFI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oYuLvn2+RimhG31QZhpdfGzav9A2Hjw8POjXynL1Nd1uMc+42Ob5jHa09WXGrrQUM
	 jmDzQUHkzI/BoKckmBayWickomPoTKNJ9TgQQemMZnBM+ypstO6A+M7fydL7Hk8Eq9
	 HW9otAtbMVAqxdMguBo3u+xKFPsM+Si2bjlAp88z217nS4G3XL2NfCAAnxxfdS+l9T
	 MLGV9Vv1fvmlwbF6A1nKVEmX9SMxe7bH1leRRE3EAnYnZuQBHCgx5NnewreHvVwIWu
	 6yGah8GzSIsNfMPvh8ysrGiqYzAmymXxivjriW2PA36J/KI5+aHwJQUD1rorgBQQPY
	 o4yhO0pWUVkzg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id C53BC40709;
	Tue, 22 Sep 2026 15:24:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id 62D969CD
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 15:24:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5462180D2D
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 15:24:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id uMy8bK2wwAvL for <u-boot@lists.u-boot-project.org>;
 Tue, 22 Sep 2026 15:24:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 9912E80CC4
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:31::d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790090645;
 b=b/H8yLwW30T7tiwdxUpcPCikw49yZj+XNMoZAXHCpOgWd7Dhx8SCcyFyG5I4S5d6qG8N
 0ALhiJw3BbKqGKCZnhdbXvK+4qwT9c1xBRId96VoO4y062dyQeFsjZuwGvrbDJ12uCUwe
 00adI7Yvtk2PoLwdCiHdmIeywjuCPxMWGoCEvg/lvUdAhBoebsqSkAe2D2KBek6HQ6x5g
 37k+vgxR5BjgsBRW7bsjFug9XqBP93rIkHQPeqK8HMjKupuAlQHXqgl+ve5Yz0k7KznJj
 bPEIgQA99n29vrSm1nNCSc/NNOgbZiOSX64NrevEzibTsNoMKQY8rVICI1LoRxnb+5Q==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790090645;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=9LFvedRM53ige81gxUCW24TjlYV06LqOWCfLF5PNjFI=;
 b=nklC4maYgUDpGgCfcHGKm0W2YaWbse5z0rghahAYjikTF3bWg2GYK3Iq3ja3TloGN9ns
 j/DiVm3RqDsbqaX8BnEOzKwyXJKLKfRNS+UGOWr561xbHFBTL0DsoBDFmPTJc6iWl4TZS
 /lCj8vI5eltVl8uBQF3kzJRu6qVQIsStvR0mPOMu1SAMyi2SciPkXZEco+R6uUBHRtOPk
 IjkTnAd8m2z4pitIznxrawyEv9JOPiR6/+XnkouZra4LH49qKPgsjMj73CMR8919U7ozr
 zg9F11lEy5+WA+8aq1jvdnOz3hCUc39ulSiRKl58J+Vxqbs4uKvzmpFJAmB3m1v/OqQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b="K1xA/lWh"; 
 arc=none smtp.remote-ip="2607:f8b0:4864:31::d"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:31::d;
 helo=mail-oo2-x0d.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=K1xA/lWh
Received: from mail-oo2-x0d.google.com (mail-oo2-x0d.google.com
 [IPv6:2607:f8b0:4864:31::d])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9912E80CC4
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 15:24:04 +0000 (UTC)
Received: by mail-oo2-x0d.google.com with SMTP id
 006d021491bc7-6b1ae7089c0so2104820eaf.0
 for <u-boot@lists.u-boot-project.org>; Tue, 22 Sep 2026 08:24:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1790090644; x=1790695444;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9LFvedRM53ige81gxUCW24TjlYV06LqOWCfLF5PNjFI=;
 b=K1xA/lWhom1V9QbQqvg7LaQGuxd26Y0L4KgKgURYC708EEmqyceoYBHNSh2OL29d9G
 XYolORD/nMP06uTX+togN396rOh30mfhNgRwC6jOxDdtWGWRpb31RkCx5IzfhsEKz67a
 JS8oeM+qNpa/od4B9vwJCdbWdLbqmB7Vix4J0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790090644; x=1790695444;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9LFvedRM53ige81gxUCW24TjlYV06LqOWCfLF5PNjFI=;
 b=wUdeVcPIKneta5bCBsunVRLOftcWFzOUPleGRvPEbSVOgLVIbILRd3kLNtZJI2rXUr
 EqlvFqrC2L0LPuuNQ/TwJRX7IWGpEZ6dcv9CCr57bu3UpladigPoRN6JmMvPU8nJG3A5
 EQzdT5Q/tfMOCVZ5egJu347xrGR8NBPG10ltje5Pb4h6ga2En202z88RvdPFjUGW6FuO
 tg07URFehmVPNM8HkuN7+M8q+fWFNIdx6pH1YO6hG+yZ53nu9h9a85f55uBgRBx2/vxE
 RXiIzsjm+QDu86zG8QSlp1u0wi6QfHjgru6NrL/8IGaiQaKXalEFQbVOClKAAzdsDqKl
 tKuw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwP8brHxHDa08ejQ0r+fiGU0FqKtz/lq6p6WAZsCP/S+KNcSSmTP7s9MPFDZfpCYAh4HmOzwDA=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++m7UEtrm0TE8C5aLwtTL2IW82WCG+nOkDdO03A5UFjaR0YZkA/w
 RXMJW7XNBk+dPAPzjmg9zqWm+2rWmGrlGGe/b4T1DbcWEQKruvXTuT4uTp4kJuK76kk=
X-Gm-Gg: AYBFou1DcX8kuuiRmBhaBw7W4soYytqpKGrFoo90H12n5xp701WCFaUn/m6t9F+Rd9f
 GTCzNuyQDweJetKqjIanu7CO6VaUndVAcvIzm+Dna52kZR9+UxYMiy7EcoMv7LYgSc/ghrYsQRT
 uPs97sBRD56i91gdg8gFzNw+K1WmfufK78kOswvTfe3XaHMwCegD8fsey/qcJaFovu/pvCVbZs0
 2uHkWJyKHgUIkfPcbWSodFhLFEGXonDkJh/TGHkBlbh1pdsT31IlokpQs7QGd1J+CD6Pz/yHloT
 0lSzKzXgefXsUre7D9in8ioqzfAGNszsa43n8Yw1RMLHtYjsCneDdG+/Sb1dsLhKkkyj5ai1wSi
 v6MOPtWj6S7iXUVwEUUAMdpso8W1jsjItCavanmv++5/+5k9TS9c0bp5h2WpQk9IiOW0KR6M8L6
 TKBRlxpSXaOiL2iZpu6EUJjV6B7s/eVPwgBEGjCWvOMgnC+lh78cNG7W+VxTRtW/TwBqnOVvhSp
 yFSHipqFvf3PRHmjsh0A8f4gxeduMZVlqQaPMPSn028NNGeJr5z+YHSOwuWt/TLw+stlPkJexF5
 hIHG0IJNFocTqVLmf0q2Zhi6WXBpFA==
X-Received: by 2002:a05:6820:2219:b0:6b1:bd81:cc24 with SMTP id
 006d021491bc7-6ca9a132e14mr12714936eaf.1.1790090643827; 
 Tue, 22 Sep 2026 08:24:03 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-48fbf4b6ef6sm1252344fac.14.2026.09.22.08.24.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2026 08:24:03 -0700 (PDT)
Date: Tue, 22 Sep 2026 09:24:00 -0600
From: Tom Rini <trini@konsulko.com>
To: Junhui Liu <junhui.liu@pigmoral.tech>
Cc: Yao Zi <me@ziyao.cc>, u-boot@lists.u-boot-project.org,
 u-boot-spacemit@groups.io, Tim Ouyang <tim609@andestech.com>,
 Leo Liang <leo.liang@sifive.com>,
 Conor Dooley <conor.dooley@microchip.com>,
 Jamie Gibbons <jamie.gibbons@microchip.com>,
 Huan Zhou <pericycle.cc@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Raymond Mao <raymond.mao@riscstar.com>,
 Minda Chen <minda.chen@starfivetech.com>,
 Hal Feng <hal.feng@starfivetech.com>, E Shattow <e@freeshell.de>,
 Yixun Lan <dlan@kernel.org>
Subject: Re: [PATCH 1/3] riscv: Fix up the OS memory nodes from the DRAM banks
Message-ID: <20260922152400.GI858934@bill-the-cat>
References: <20260922-riscv-fixup-memory-v1-0-83b3166320e6@pigmoral.tech>
 <20260922-riscv-fixup-memory-v1-1-83b3166320e6@pigmoral.tech>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="xnkginduUWC/G2e7"
Content-Disposition: inline
In-Reply-To: <20260922-riscv-fixup-memory-v1-1-83b3166320e6@pigmoral.tech>
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


--xnkginduUWC/G2e7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 22, 2026 at 10:38:45PM +0800, Junhui Liu wrote:
> The device tree loaded for the OS may contain a static memory
> description that does not match the layout determined by the firmware.
> RISC-V currently relies on board-specific fixups to pass that layout to
> the OS.
>=20
> Update the OS memory nodes from gd->dram[] in arch_fixup_fdt(), as ARM
> already does. Platforms that need to keep the memory description in the
> OS device tree unchanged can disable CONFIG_ARCH_FIXUP_FDT_MEMORY.
>=20
> Disable this option for the generic Microchip MPFS configuration. The
> supported Icicle Kit device tree uses multiple memory nodes, whereas
> fdt_fixup_memory_banks() writes all banks into the first node and leaves
> the others untouched. This would duplicate memory ranges, so preserve
> the existing memory description for this configuration.
>=20
> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>

What is Icicle doing such that arch_fixup_fdt shouldn't be written to
handle that case correctly (and is it not handled correctly already on
say ARM?) ? Thanks.

--=20
Tom

--xnkginduUWC/G2e7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCarKdkAAKCRAr4qD1Cr/k
ClAsAP0YztM5W0+x3svvn++qJA95BRElO5pch0W+ty9fJX5RLAEAyn8f0Of59Ld5
vUmaWnzDoUJCBlJzyxm9oVRjtMbPnAE=
=wRk/
-----END PGP SIGNATURE-----

--xnkginduUWC/G2e7--
