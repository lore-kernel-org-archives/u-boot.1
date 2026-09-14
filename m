Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC676C88E73
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 20:42:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6365880AA0;
	Mon, 14 Sep 2026 20:42:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Ylo9av3j9N-q; Mon, 14 Sep 2026 20:42:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 8264080AAA
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789418558;
	b=Wc840GcsFHzoYpgnOopWv3iEowJB1ezHNo+vHz8tgCvohCJPNaKhgOO6ZqlCJvcpZ6u1
	 5N489cVXG5+UEkDn/xmNB4jC62s7Oa2GsYSO8emRnpO4gxYHA3mdM5to73heB6tu6lpXQ
	 xg9TvjiptGzcF1Znvc1bAHW5yX74BJO5zcIzkwAI44Fio7smNFbqNTnAMslqtkP42ZWJg
	 7POXxAgDACFyHqDcz3Cz9wysbT7MgydAQXNqYzjy5IGivn07em1Oy1gSfHeFT/X8VmVbJ
	 QESc/27wtElKFbsS/wvulaAL7VylFOn3fJ9Jjpg+b/Ta7WJwVrL0Y69DfB8btP9pYBQ==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789418558;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:
	 X-Clacks-Overhead:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=WgCtRCkJyotUGjq8zrBPgwbVgrRGMm48IZk/dOCtFBg=;
	b=jjWEGUZxADBP6k5N+8QiZkI0MB0uu/uSgyY5Ps+WgClCKAxQvw9sTHUhZi59eOSlkdfw
	 gyPplVbdnd6B6y1n2KmCNd8Akg0dfLtyWQUsU+smc97jq1HEaneeag8VXRwt+HdX3GtF+
	 otr5kvR1GKcu/HzGGoihnnBZboO4q70kLsxr7Vx3Ljji4HNd7NWUhdIfbGPF4t9ofmAWB
	 Y2SL5l2fJREaBGPjF1ndRKl8soVgylnROeXpy8CkYgaCi4EnQ1HxmxAEVwnGH3s1JHP0w
	 y0vXKl54XE59P3N7dpDqnt+QkyMqqOXpPOrppwRfcLTzeUfmRnbGukoMO/sZZpH68+A==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789418558;
	bh=WgCtRCkJyotUGjq8zrBPgwbVgrRGMm48IZk/dOCtFBg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vHPARzCAeXHDG9shRPyFxiuzUlEr0YMLekUFejKf8CkVJ7u7KeOh5A4hum7HkBSF2
	 MVg9AhSEA91SOgLSKknDLM4ArQkICFzwJHcccs2tBNoHnnRbVFW5+6atYgf9qAY2JM
	 l4NnOzhs/ef4zOeOvwGQ0+kYPcBaf3CAcDqbR7ojs/ZJ/kIE1atc7pSRd/iE35oBrm
	 ldK2Bv9/VX97P6mVRHbD9Z9rJiY/tZ128qolQhP2Kvx9EJH5C+qjiZCDPdNLDQ28fW
	 3TIU6dq3egRM1i2mVcEaIjypvYV8ACnyBgEZFb+plGeZ1WhyLCBzwtB9fqQIW8IDoF
	 iWfE0C3YLL42g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8264080AAA;
	Mon, 14 Sep 2026 20:42:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 35F03493
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 20:42:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1B516400A1
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 20:42:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id aj7X8TEZgETO for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 20:42:36 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org 20A1240099
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:30::1"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789418556;
 b=rpYiaDKhD73COPwCkHjKOIfQKZIO1QR6FBnuFxfixxYrk9bDuKHlixCOjaLlpns+GNyw
 li4fSKxqpjPHalw7iov0sbKRBJcFUgED4SDz5Y82fD4uDdHJXiHn+b2PObRLz3zQ1EnDc
 vA55HKhWPZz/Cwr2v8XJT/AnJ1BTamekf0PPizqMJhw8/c5J+GtIHCSsyIUSoqWeimrkN
 tk4qIa4ZbjU1Qh7kKi1mcyphVga7W2YD7TwoprHiz8iRhh0SpUAaRT8a8KtfvJ6kD2rsv
 NnWzjgNUBwzPQGdtFu6RtlU8OoOQ6EE82ejLkaxhfMpwOojBcPbcKO56Jj0NtLxK6eg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789418556;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To:X-Clacks-Overhead;
 bh=WgCtRCkJyotUGjq8zrBPgwbVgrRGMm48IZk/dOCtFBg=;
 b=PUY/Wfc0+nOd72BLYKWDUIDQIWW/z0e2O1ln7g0GdbVOmOMDV5v8P1iAOv1V7Xg8cf8L
 cX4SFcwJ7CI/lZGhkX1DsA3CbpIWN04cur/CU62tP1+oM+2tktbtJrJeLnPDAWW+Hn9sN
 wewBwvP8aDHPnUNzUYGSCtwPe5mwWWg4nUPy4VrwdzwwWhrfSLh87jms2L4SQV3W0WNA9
 Qn4dmo+L9I+bdJOeeSkRma/AX3IB6wkWvKiKlLXRQLbCeJzUqOpMZx5/32s0q37+yLZwy
 a69SfvePrmNF00HtSg77GfEVl+YYjvXsgb9Q0i7T4pjA/+WviYg5h9PcoMPXNsHYc1Q==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=LQfDOldR; 
 arc=none smtp.remote-ip="2607:f8b0:4864:30::1"
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2607:f8b0:4864:30::1;
 helo=mail-oa2-x01.google.com; envelope-from=trini@konsulko.com;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=konsulko.com header.i=@konsulko.com
 header.a=rsa-sha256 header.s=google header.b=LQfDOldR
Received: from mail-oa2-x01.google.com (mail-oa2-x01.google.com
 [IPv6:2607:f8b0:4864:30::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 20A1240099
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 20:42:35 +0000 (UTC)
Received: by mail-oa2-x01.google.com with SMTP id
 586e51a60fabf-456b57c99e2so611128fac.0
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 13:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789418555; x=1790023355;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=WgCtRCkJyotUGjq8zrBPgwbVgrRGMm48IZk/dOCtFBg=;
 b=LQfDOldRdA4oEdZ+hT39Kfzei4FLjZ4fKNDj47vpENc+l1alB56YqtMMcKTyG93RHB
 btUfxEklLhZfsbNv1wX7sOo6ChQzxozGDJHGA6ZFSp3nop9ParZLaRyD8ZJWgIDlQ3G2
 5iaTAz2qKueCUJg2sKx3OpU98Llz5LJdx2Gf0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789418555; x=1790023355;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WgCtRCkJyotUGjq8zrBPgwbVgrRGMm48IZk/dOCtFBg=;
 b=R8fPb/Sp6u6oOh9RqBl/ab2Ua9ugLtS6S4AN+gyOdeuqKshoVawjg3OyLVS6ooIEQs
 ijEBguTpA7uDDoJee8h/zRod3ogOOckLlL9MHhoJW+YmK6b8DqKql5kYVOaGyOrXxrWL
 JrNki2XHnfCxvxqfvBnon1rS3GWldhjnx68hXoumLiuwEjc26iyYKJK8IHcrJT7HeQE0
 sZVYSAUtd9VmGiK3hIrfS8eRN4IORG6CohMcq6xkScPzHVw6ZGssNtDgVIjH2bYpYfSq
 rdbFNJEHTbBzTw4gHp/2ourBijyYc8580quFcjD7iwo0mGnbEvyXuK4hypmYkTmqI7Xm
 P05Q==
X-Gm-Message-State: AFuF++lXVVpZioowcoGYqviW68YBXaltiiIASstaWRPi7vxVPESGJABC
 UrzkLAJ/JGAt2Iehrh3IaghUTu8+v5L3x4zw+QVW6PnabYowQzDXHtWeETFo4nGp56at1vxi6Zn
 Im2BNyfZoV+8kSb8=
X-Gm-Gg: AYBFou1kZfVBX14BorLageQ4EoMVFab7H5TH5QpnxZDkpx3j+rZ2ZTf404EYlZDxEtr
 dFkrzmvjLDZO57E5MViATs75rkE4ReqBkzJfJQEVBMGCUidN9rKACYQfc3xASVXf8kJpnJfjb5F
 OdieXqQj3TassT7pXmEBYyZEbfJEHPSARSiG5lNrZwMxDJaYfXYNPoq0ZbH2O6L3zV3yZjkosZF
 qZvWfoRuUqpL8XOtjvFabJgDH45iEx56D/dlPxSj7Kh82RRm4t8tqkyBVtj994pl+6xUu/Bgyow
 I9IS2cEDjaexlKGePdTFsWOxZWiacJ97xsu0p1gTmNtz+HMo0hANHEO+D98Kwz1N534aRVdpkwd
 3borlcyjDQx7NwiNSh9eZ2OkWDbwsHIv6OJisAA0YQDlAm5zdPnQkAP0BIwZnsqF/xt78aiNlC+
 PqNaepvyB++hnRtOqiMN9c8ET/8rFm4E7TcEFZrmuAazul6rLYHN7FbxfuXiSgh76P/Y2f2mGGK
 5+qVTPko0K2zIOMDxJhkaaPZq8zN7gyg/gSDWgK7DAGFFiWyycsSwuBBseLzZrkwMHKM5CdqB/q
 e+szCWmvjaSG3uUS1ZOONjRZynD3WDx5
X-Received: by 2002:a05:6870:89a7:b0:470:e96b:43e4 with SMTP id
 586e51a60fabf-482e570b757mr605373fac.16.1789418554808; 
 Mon, 14 Sep 2026 13:42:34 -0700 (PDT)
Received: from bill-the-cat (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-47df962a078sm10530081fac.16.2026.09.14.13.42.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 13:42:34 -0700 (PDT)
Date: Mon, 14 Sep 2026 14:42:31 -0600
From: Tom Rini <trini@konsulko.com>
To: Linus Walleij <linusw@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Stefan Hansson <newbyte@postmarketos.org>,
 Stephan Gerhold <stephan.gerhold@linaro.org>,
 Jaehoon Chung <jh80.chung@samsung.com>, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH v7 00/13] arm: u8500: Enable upstream DT based SD card boot
Message-ID: <20260914204231.GA632314@bill-the-cat>
References: <20260901-ux500-external-sdcard-v7-0-427923e9934b@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="64pYqV0jwR6u+X7D"
Content-Disposition: inline
In-Reply-To: <20260901-ux500-external-sdcard-v7-0-427923e9934b@kernel.org>
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


--64pYqV0jwR6u+X7D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 01, 2026 at 11:12:58AM +0200, Linus Walleij wrote:

> Switch the U8500 Stemmy configuration to the upstream Samsung Janice
> device tree and enable booting an EFI system from the external SD card.
>=20
> Add compact DB8500 pinctrl support for applying the default states from
> the upstream device trees. Extend the PL180 driver to configure Ux500
> signal direction and the SD card supply voltages.
>=20
> The upstream device trees describe the SD card supplies through the
> AB8500 or AB8505 PMIC. Add support for the AUX3 regulator used as
> vmmc-supply, using the existing AB8500 PMIC driver for register access.
> Enable fixed regulators for the vqmmc level shifters used on the other
> supported Samsung boards.
>=20
> Backport the pending Linux DTS fixes for Golden's duplicate regulator
> name and GPIO key labels. These patches are queued for v7.4 on a locked
> down branch:
> https://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git/=
log/?h=3Dux500-dts-for-soc
>=20
> The seven supported device trees are packaged into a FIT appended to U-Bo=
ot.
> The Samsung firmware machine ID selects the matching tree at runtime. Cod=
ina
> TMO shares the Codina machine ID and is distinguished by board ID. This k=
eeps
> the board-specific SD supplies, level-shifter GPIOs and MMCI signal-direc=
tion
> settings in their respective device trees while using a single U-Boot bin=
ary.
>=20
> This has been tested successfully to boot PostmarketOS on all the known
> Sansung Ux500 devices using the EFI boot flow, with some minimal changes =
to
> the PostmarketOS to use systemd-boot and compile in the right EFI kernel
> configs and EFI stub.

The MMC changes least to a failure to build on at least vexpress_ca9x4.
You can see what boards use drivers/mmc/arm_pl180_mmci.c by doing:
$ grep arm_pl180_mmci drivers/mmc/Makefile
obj-$(CONFIG_ARM_PL180_MMCI) +=3D arm_pl180_mmci.o
$ ./tools/qconfig.py -b
=2E.. wait
$ ./tools/qconfig.py -f CONFIG_ARM_PL180_MMCI
11 matches
stemmy stm32746g-eval stm32746g-eval_spl stm32f429-evaluation stm32f469-dis=
covery stm32f746-disco stm32f746-disco_spl stm32f769-disco stm32f769-disco_=
spl total_compute vexpress_ca9x4

Thanks!

--=20
Tom

--64pYqV0jwR6u+X7D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTzzqh0PWDgGS+bTHor4qD1Cr/kCgUCaqhcNwAKCRAr4qD1Cr/k
Ch+QAQDIyAGxI+xgILmB02IDm8MTnJP9HQktgFBBJ8+B+SrxGwD/R+KK8UGxTdCA
KQEQkakehfVczDJ5nRKjWNkL0iwucAE=
=fRVV
-----END PGP SIGNATURE-----

--64pYqV0jwR6u+X7D--
