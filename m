Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BBDEC79F9F
	for <u-boot@archiver.kernel.org>; Thu, 10 Sep 2026 14:30:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 40435810AD;
	Thu, 10 Sep 2026 14:30:35 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id rk30MPvk4O1P; Thu, 10 Sep 2026 14:30:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 4442981083
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789050631;
	b=tbayN7fg5c9PQl7E7p56FSREQ2LeMRulMFb+85PqJ5RTMfkhh7bkXClrzTeDn1nTiYl7
	 +orMVe52SetfDUkSljDOpan60Jzw5LE4gIoNzErMLkbNl5TMzVugHZP3dH4Vzghd2Iqyo
	 Dlr1FEbi3ov+12U1FXA7s/eAHDN4rnK6gSNTu2as2pL8QXtH6nVXfQ9K8zQIZrCfdAh1M
	 e7qduB0DUTCA9c1lR4LGOqYEZUnXf80EarxFQW0sRdZNaVYbvpV7PQ6MOfQyYGFdf0qds
	 Q8p33WdfcGk57y4Ka1B8rEWPZcTxT4X+lk1CZ0bHKnmiIlGMNiMaVoTL1oVn8iOKWOw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789050631;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=x9hp84FyHRbjZgcu7SHL1abIsUBUrrpvMTsl0w2n2jE=;
	b=k5vy1sHTmx0Pb3kZvjL2cDjVA5bNFjhrkPI8aBnpZKXvpUti2S+ANQbZxlI2728e7IRk
	 E06abF/75udfMjIXpTkzRE8+Mlju8lqKW3ELz64zaC8udNQHmqIUAAUat3pSg9OAJaf8C
	 8xtZusxy2pihy9r9sMSFMWAthqdAeWxjCtt63cVfVgQVkIfkH6PIwWyNAQRMzSFBNcJ4a
	 eLGNZdGmF7LkdV6BlIHdahaMVAFubn3AsmYOh9rruBd36LI3DOPggZIdAmR2Dv0QqycNm
	 d58eUiiWhuda20+F6sa6Zn7NCDmPUGqt/tBltGpAR1F95z8KhYIHtHBVH5XaXojd2gQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789050631;
	bh=x9hp84FyHRbjZgcu7SHL1abIsUBUrrpvMTsl0w2n2jE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=Qxa/GatV1pgMTif/CydgjmhahPg40D4q4+9TDK8cPYH7XDI7CeQgCYXtx03xhMFey
	 fX75W/ekXM0moedcDsJTpm14lVNOPv1wnXLFluzLmaDPrdgOmn7nfeNJ4+IV+ugKly
	 z7nrphYhIJcpY5JwLD33S+JalG2tLPYHWVl0o6bieJ9/8kZMJceywwbznnRIh7wfa4
	 Z5dAx3P6aDXFa/35eGTg+LfxSY/rMyaU37zamQzH/d8wvvx0pj89grIylvw8uwvvoz
	 Jq3/mJSKymC99SVm8GBPAvmbRU7xn5TO2fOyCKW+oSzjTlol9CsNDm4+iAWwZvDqrW
	 DhIMb/P7wwR4Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4442981083;
	Thu, 10 Sep 2026 14:30:31 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 22DEE268
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:30:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 13B4140A85
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:30:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 1_sPpCDpWdNG for <u-boot@lists.u-boot-project.org>;
 Thu, 10 Sep 2026 14:30:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 6AA614084F
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::534"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789050624;
 b=QL9IK0U6vlsD9FRbXbWvPBnCcFPEEdA8KaVVwxxe+wZ67OQ9l3s73SYTKbCPFmGzpGmQ
 qUkBNgK8XjnQqnmXL0cvcJQvRu/bYO+KACHjWp3TNuZCwFI/0r4HH2jx0/a+FJvVF3aPr
 hR8DWdurMFygh7HYko8dFqEMfCl7oCLB1hmD5EUOFnDAM7ZhKeq+tVm8gjJ6cVLck9bvK
 LkcKIippP/vZrlAj6/9La11QUAUd86976ZJC/3CZ3OKsrmfrZ6CJrFDPbQfW+I0fVWnal
 5OZZyBQ1j2vN/QL1qtx5fALfi/e4nVsum6C75p1alD98aKnsEboG6fQazv7P6DyvfLw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789050624;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type:Content-Transfer-Encoding;
 bh=x9hp84FyHRbjZgcu7SHL1abIsUBUrrpvMTsl0w2n2jE=;
 b=srmN0hwAWGxuYcJeyz6rFr13GZHj4FfB+pv+9xiLREA6T9OWxK0wHeKCxsXuTPPPABSZ
 XgWL2bFfl9ueDESGWOglnVPoRi8SZiCblDkwo35SAOM7XPlub2IVj2DCITDIUj6if0GNe
 r/BhQDvTFo9hxSt+a+TKjq054J1ZdK42WcWhX42+qzsjIDndkylPvYRdh2cv+RuCeEHsl
 y/lwGg+GDE15jW7yNvhz2E1Qjdf8gw4x/GV4y17g3PHx4sLdWBKF6oYmXzl1lUeuLkFRN
 iJr+7e8GSMoXHVXX4hZ6yJzgA6WRo/8axI3CnqUJ2fGBzCDT0dCaczG9EQuFXsEd/OQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=DbZivT3Z; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::534"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::534; helo=mail-ed1-x534.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=DbZivT3Z
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com
 [IPv6:2a00:1450:4864:20::534])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6AA614084F
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 14:30:23 +0000 (UTC)
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-6a7ea0046deso9151886a12.3
 for <u-boot@lists.u-boot-project.org>; Thu, 10 Sep 2026 07:30:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789050621; cv=none;
 d=google.com; s=arc-20260327;
 b=Ck3eSVrhHYY91Wojx5lI2f9QqtaorNytSRWQysmQleolL9WN+qZKqCDJ7zF9ILT39g
 rpIPxDds7QNB2nEbwJDQGwu2qWFBwV9b2Qwirm5ISrgscy9eYQiL7qT6NQbFoWlcBEUE
 1vnNsPmEJUNaIe7zR9ikEYRZe+tm+x0ScyxC66q+zB3xWH3Zl2ZIotHwTevcsSVHQshM
 y39oe82/aoJ1sN+YH6xDMPBrX7/r6E+qIWCChsv7/W2a1jStDqVTWrjR7nkWhAfuuXZf
 r/Lq3Yd9TtHYd54sAPNZLyTXg6rxirtQwDw5ceq+yaffM2Ai+kd0ZHXndzRfyuEWYOdy
 KxOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=x9hp84FyHRbjZgcu7SHL1abIsUBUrrpvMTsl0w2n2jE=;
 fh=dnDU5bLbo4WaoNdzuhme+T7/Qa0dDTGmjpLFhQe4DUk=;
 b=Ou3f+G76p0KVHfbkiRJRYgRCsPqZ9x0FDzWIrzU2/OeaHKJVremPIiC01I82fnWM+d
 B4R7/rA4rlzDoTeoMdbwetJlP3CGNaj71sQEMVHP1UbqdxZ5h/xNiRQLfn08Y9AYbGYJ
 cXpyidpRvloyD/zlGOV5TufYEn/2YIoVI7LUoQk7N+tQOC1CXt6WCP+53MW7iLLkWca6
 YTbSF6Rgm+5gbPje+rz5At0CLUx21IFFYfFa0ctXTKQoc0/ODza/DangHg89/aPFKRYc
 tOzcnWb7FFnS/jCPt7I/dCTL7cQKhcKe5/5tPyfN4Er5lhYIR+gqUEC/9P5W0cNGWjed
 PEYw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1789050621; x=1789655421;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=x9hp84FyHRbjZgcu7SHL1abIsUBUrrpvMTsl0w2n2jE=;
 b=DbZivT3ZzqDWYhAiFvvlwHp2U0X/rsav44GtzzY7emHZNWuDJ06wrXsIAhRqq8/jSf
 8ocUGuqf0vmaVuDqF/DiAdGMvvy3acUThLG6fPPJosfYYOGDXvlYsPsC6gj2UADMrECf
 TfToQvYzgoB/wdvVxCID8NY+DmGd828DDTjLI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1789050621; x=1789655421;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=x9hp84FyHRbjZgcu7SHL1abIsUBUrrpvMTsl0w2n2jE=;
 b=SYQld3DqpKq42oCLJ7d6JwpZ3TidnMahL2kHeJuV6Dt4+Co2FXfFG6MTGqljRQOegW
 2UHIBWsNnUlINgjf8Vp92sLO6dugTBqbGjJqeYBFUwrjA1QEZSE11Xvyt+rk3g4O/dkc
 mvcJwR+xY0Fwt1ev7TSu5ZDYJNxKXLbYqDQxE/AEnBGKmwTJC+6jmbk+Xo0hCttA0HJC
 z0/yHgp4v+epl0xAuOBxspjAIzRn24vE0CqxAs8QqS8zU2zQkid2SmioteKvOXMwRPxf
 DGn2XXt/Wc2JU8i22NV4S22SkNWguE2+h/vPNmlr62v5MrwxsheO04SFVLHGz4gYX5rM
 OPRw==
X-Gm-Message-State: AFuF++kyxMTN1Mu/NYFE6fZ93OiGXBekMJdgI3OhQqnJouC1I+6mWXtn
 aCTgl9p/+DdFTnqC/ts+NbF6bxRxV/tU4x243VI21dxLqrMk8CpuP2HPg0ephUkTZSNTAhUefpD
 +ryg/TMCJAeJw2014ClYVTGCL9ORHY4yFGoH/ZDva
X-Gm-Gg: AYBFou363YmMUhEtvwjEh90cofg97M5pLmP5lE2fj7RWBn1XNTgyTlpNZs/u2lmSMgr
 IQac58ibxZbJfu06Q1UiI+ZwdJuwD7cuLBUJO09YMrBaj/RpMz2fR+zpE/i7QvPV0k3b7eGQ8W3
 EezI2q38feoxsMa8xZ/1XnVJfeQjY8uPdQQ6rD2/peVy+urG5svhzgFT5JBCiuQ4afzI31rHlwp
 5NDKH3900gdCgWWbUNUuWGF2/QE8wLLt/tbfN9pyQJK3bsycyJTx9vnZQ+MDmN/Qy/sNTKPHxEN
 gaanxDWjfWM3vPecCZJ4W1YSOmND7h1zDLJqrcNklVqQeYCSpP7hDQ==
X-Received: by 2002:a05:6402:3906:b0:6a9:a311:25dd with SMTP id
 4fb4d7f45d1cf-6a9a311280bmr2304383a12.17.1789050621254; Thu, 10 Sep 2026
 07:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <20260615175118.53720-1-joaofl@gmail.com>
 <20260905102431.426747-1-joaofl@gmail.com>
In-Reply-To: <20260905102431.426747-1-joaofl@gmail.com>
From: Simon Glass <sjg@chromium.org>
Date: Thu, 10 Sep 2026 08:30:09 -0600
X-Gm-Features: AcwNN1WYGyLvfoZVl3SGN4NSI27WSe8R2EyeyTNbZTvCfujamxp6EeQnHhbxTjk
Message-ID: <CAFLszTiRWDQyLWnJOVhmSaeTGY1y_xTz9+6v_tqspVWp2TXvEA@mail.gmail.com>
Subject: Re: [PATCH v5 0/3] spi: Introduce driver-model support for SPI EEPROMs
To: =?UTF-8?Q?Jo=C3=A3o_Loureiro?= <joaofl@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>
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

Hi Jo=C3=A3o,

On Sat, 5 Sept 2026 at 04:24, Jo=C3=A3o Loureiro <joaofl@gmail.com> wrote:
>
> This series adds a UCLASS_SPI_EEPROM uclass, a driver for AT25-style
> parts, a sandbox emulator and a DM test.
>
> Simon, thank you for the detailed review of v4 - it was a genuinely
> useful read. The point about the hard-coded 16-bit address in
> particular sent this somewhere better than where I had it, and chasing
> your comment about the non-standard 'size' and 'pagesize' properties is
> what turned up the atmel,at25 binding already sitting in the tree,
> which now drives the whole geometry.
>
> v5 addresses that review. The main change is that the driver
> is no longer hard-wired to a single 16-bit-addressed part: the address
> length now comes from driver data and can be overridden from the device
> tree, so 8-, 16- and 24-bit addressed devices all work.
>
> It also fixes a crash that v3 and v4 both had, and that I only spotted
> while re-testing this round. Adding the EEPROM emulator to test.dts
> makes "ut dm" segfault in dm_test_spi_flash: that test picks up its
> emulator with uclass_first_device_err(UCLASS_SPI_EMUL), assuming the
> sandbox SPI flash emulator is the only one. The flash emulator is bound
> lazily on first transfer, so a second emulator described in the device
> tree is bound during the devicetree scan and lands first in the uclass.
> sandbox_sf_set_block_protect() then casts a struct sandbox_spi_eeprom
> to struct sandbox_spi_flash and writes past the end of it, which trips
> the dlmalloc heap check. Sorry for shipping that in v3/v4 - my testing
> had been running "ut dm spi_eeprom" rather than the whole suite. New
> patch 1 fixes the test; with it, "ut dm" on sandbox reports the same 28
> failures as an unpatched v2026.10-rc3 tree here (all fixture-related),
> plus the new spi_eeprom test passing.
>
> Changes in v5:
>
> - New patch 1: test/dm/sf.c now asks for the emulator attached to its
>   own slave rather than the first one in UCLASS_SPI_EMUL, fixing the
>   segfault described above.
>
> - Commit message on patch 2 reworded: imperative mood, "driver model"
>   rather than "driver mode", and it now explains the motivation - what
>   these EEPROMs are used for and why the uclass is wanted.
>
> - SPI_EEPROM_CMD_SIZE is gone. Address length is an addr_len field in
>   driver data, overridable from the device tree, so parts larger than
>   64 KiB are handled and adding one later does not need an API change.
>
> - The AT25_CMD_* opcodes have moved out of include/spi_eeprom.h into a
>   new private header, drivers/misc/spi_eeprom_priv.h, shared by the
>   driver and the emulator.
>
> - The read path no longer computes "offset + size", which could
>   overflow; the two ranges are checked independently as suggested.
>   probe() additionally rejects a "size" that does not fit the
>   configured address width, so an offset can no longer be silently
>   truncated.
>
> - of_to_plat() dropped; the geometry is read in probe() instead.
>
> - "size" and "pagesize" are kept, and "address-width" added, because
>   they are documented -- and in fact required for non-FRAM parts -- by
>   the atmel,at25 binding in dts/upstream/Bindings/eeprom/at25.yaml,
>   which is already in tree. The commit message and Kconfig help now
>   point at it.
>
> - Compatible list expanded, taking the strings from that binding rather
>   than inventing them: microchip,25aa010a, microchip,at25160bn,
>   atmel,at25256B, st,m95640, st,m95256 and st,m95m02, plus the generic
>   "atmel,at25" fallback the binding requires every node to carry. A
>   node matching only the fallback is fully described by its device
>   tree. The at25010b/020b/040b/080b/640b strings suggested in review
>   are not part of the binding so I left them out, and microchip,25lc040
>   is in the binding but uses 9-bit addressing, which this driver does
>   not implement yet.
>
> - Kconfig: "depends on MISC" dropped -- the misc uclass really is not
>   used here. (For the record, I2C_EEPROM in tree does still carry it.)
>   The help text now describes the uclass, the AT25 driver, the
>   supported address widths and the read-only limitation.
>
> - include/spi_eeprom.h converted to kerneldoc, and the outer #endif is
>   now commented.
>
> - The sandbox EEPROM node in test.dts follows the binding: it carries
>   the "atmel,at25" fallback compatible and the required size, pagesize
>   and address-width properties.
>
> - Added my own copyright line alongside the existing Philips one on the
>   new files. The first version of this series was posted while I worked
>   at Philips; the rework since is my own.
>
> Patch 3 (the emulator and test) is otherwise unchanged, and I have kept
> Simon's Reviewed-by and Tested-by on it.
>
> Simon - please do re-test rather than let those tags stand. The tree
> you tested for v4 segfaulted on a full "ut dm"; only "ut dm spi_eeprom"
> on its own passes, which I assume is what we both ran. New patch 1 is
> what makes the full suite pass again. Patch 3 has also changed since
> v4: its DT node now follows the atmel,at25 binding, and the emulator
> includes the new private header instead of the uclass one. Happy to
> drop the tags if you would rather re-review from scratch.

Thanks for the v5 - but there is something a bit odd about this series
in patchwork:

https://patchwork.ozlabs.org/project/uboot/patch/20260905102431.426747-4-jo=
aofl@gmail.com/

There are three v4 patches and then a v5. Can you please try to resend
it (perhaps as v6)? There should be three patches all connected to the
same cover letter.

>
> Changes in v4:
> - Emulator frees its backing store in a remove() method.
> - Full kerneldoc for sandbox_spi_emul_get().
>
> Changes in v3:
> - Reindented with tabs; the series is now checkpatch-clean.
> - Dropped the no-op write stub in favour of returning -ENOSYS.
> - Removed dead code, fixed the read bounds check, corrected the
>   AT25160 geometry, switched to u8 types and added a MAINTAINERS entry.
> - Added the sandbox emulator and the DM test (patch 2).
>
> Jo=C3=A3o Loureiro (3):
>   test: dm: sf: Get the emulator attached to the flash slave
>   spi: Introduce initial driver-model support for SPI EEPROMs
>   sandbox: spi: Add SPI EEPROM emulator and DM test
>
>  MAINTAINERS                    |   9 ++
>  arch/sandbox/dts/test.dts      |  16 +-
>  configs/sandbox_defconfig      |   1 +
>  drivers/misc/Kconfig           |  15 ++
>  drivers/misc/Makefile          |   2 +
>  drivers/misc/spi_eeprom.c      | 267 +++++++++++++++++++++++++++++++++
>  drivers/misc/spi_eeprom_emul.c | 130 ++++++++++++++++
>  drivers/misc/spi_eeprom_priv.h |  18 +++
>  drivers/spi/sandbox_spi.c      |  37 ++++-
>  include/dm/uclass-id.h         |   1 +
>  include/spi_eeprom.h           |  95 ++++++++++++
>  test/dm/Makefile               |   1 +
>  test/dm/sf.c                   |   9 +-
>  test/dm/spi_eeprom.c           |  46 ++++++
>  14 files changed, 643 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/misc/spi_eeprom.c
>  create mode 100644 drivers/misc/spi_eeprom_emul.c
>  create mode 100644 drivers/misc/spi_eeprom_priv.h
>  create mode 100644 include/spi_eeprom.h
>  create mode 100644 test/dm/spi_eeprom.c
>
> --
> 2.55.0
>

Regards,
Simon
