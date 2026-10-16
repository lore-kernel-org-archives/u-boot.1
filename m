Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AC0BCCF2C1
	for <u-boot@archiver.kernel.org>; Fri, 16 Oct 2026 21:54:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4062E816DB;
	Fri, 16 Oct 2026 21:54:28 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WWUzWl9SHAkm; Fri, 16 Oct 2026 21:54:27 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 4B67E816A4
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792187667;
	b=AElhxwfx01PeucsNylHvHdWDHCa4UYm5R/BurFTMa8p1Pb16iQ6d8iknT8Ns/8jkcSbM
	 nWGbO/tjIIi4SbpgeRhjYq22b52UXzltwjRMBKVtGJ+UIWt+RkrjavmAUoa3LvEfRigEN
	 NQDR6LlTXJYSzRpiLzHKOc1+urYMSIlHLfm04DGrSgc2xrBAuWSvmHWHxHXz7B7yGQhdg
	 Kiq/briQF54q0T6VsDTjTGpvLG1omu5a9CKtQIwhSO663BxThdOAQ/9qTGNhKK1hYyW41
	 QxVNa9sANgDBlfiShW7OI4N7lVvOGnCGZCEPRmY22kjL9WO1xZj+BkurhAXho3IX1Dw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792187667;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=+lDT/F7D1EU0AN08t8QCFgz6smM4tOE2FK6QMBOjypM=;
	b=JVzYTbAldK0q1EmgePLGw+wjK2AirZ0qwE1nNNyYVyIm1+CgWuEcVB7K8SlIruqBKstn
	 oa7oH8dt7JFjHdunrVSxYH6ENsLxKEPc0GBuZqRJtn0VdrFRlRn3VZq65fHIu7PkNUspU
	 z3Dat9jy1CraZm2b5k60Eve+Hn2X3DWVuXbrB93okoA7B/Kl82aMZAkzsm+1GQOK/HF1J
	 bqQP+yR0uvLIJOJcMxUGW+zZsQtqV4ODtOXZzSeWZAar9gND2rEx75aT2nAOp7iw9XdD7
	 f6UpSNegvLSMZ0Ypio0kUFLhdPobB2dOBVZRE/jMr0zxZAo9CFzoHaSR5lGpOA/kXfQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792187667;
	bh=+lDT/F7D1EU0AN08t8QCFgz6smM4tOE2FK6QMBOjypM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=BPzJxkgj+FDfnFXIP1XR6LGw9TJXh3EL8HwyHsrHUxE8KBjBKD2prql6waNJwY92x
	 vao6t16QRnvO/wfvNeVCJ2oPMfdMkYwneC8AUGB5gCB5QzjCjyWGWFW+p/SyIyAeu+
	 KgNuKKO3zG8CHTzPgZfBwlXA6ByE6KI80COyusO2M5keYgMZxRRJlC/IUsnl+Q9rfe
	 8zzKsVwEqHZ5CMsaFvcseKUIAkCCcR4/ldnXkwtBnI5aqOgtiniTm6Md6ecqd4/933
	 e6vZxzoW1xED/wyUorrQ84cq3ngj82zHOrKgLWTMPgLbIjJSEzU3v8YGUwojGnGCLe
	 A1M61L8rWhYRQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4B67E816A4;
	Fri, 16 Oct 2026 21:54:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id 08162255
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 21:54:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EE205409BB
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 21:54:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WhhSDsnrh5yp for <u-boot@lists.u-boot-project.org>;
 Fri, 16 Oct 2026 21:54:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 0F1D0408BD
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a2d"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792187664;
 b=F4sG1g2w02gjeumWVshLV46iqqqgPJqNUwyckMscGbiqJU07YBK6bVZEX/pgbfx0GUuF
 wi5Z42BLFq/u7zELAwVmv4+65lBUZS7DPsC6Tg18k1dBbfGnWbb3gNP/YJ/wQgPYr/R4k
 KFqFqzyNpT6Xquw5UInKcie2n7cyJOrn9OWmRZtOdEYc2PO/BmeLDFGWOjVyRs+oXrTAH
 KAA7zhSeA7Tukir3PVbbpRyXXP6G1Uv+MVDP89T8WaAiWm3oz/SQqhVtANml/M2iDd0+v
 7CUK8G04IJRC5ZQTaTd38IAj4NJ3d8LYEsnHrDudTKKqozPJ2EkqFPYDkAWceY8g4WQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792187664;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:Content-Transfer-Encoding:In-Reply-To;
 bh=+lDT/F7D1EU0AN08t8QCFgz6smM4tOE2FK6QMBOjypM=;
 b=i9GEtkN2lvjswq70jFrbZxxEJpgCmqsmpUnGzI4eCVwV/aBmfH+BFASKfjUr9gRU9nJT
 r3aogy5+o5kfN7KunjoX9pfi49NJ9D/O8bVu2xdLG4wVDXPdSPN/3WOgneG68y0DFwgc/
 aLPxTMPEJxyOGh4PJkLVoXAH/yYVPiwLwGiyPcso9k8buvDOK8DDOeG4nwzZQfpOadSzG
 7k1L85gdTAKRhXs5eerR64gkGMuOj+DnCwJ7LXuJcgh+RvzTgMFoDfu8oBl0Jf0LdzMLD
 HWBO8hgoI2YAdRxHSZyVqGevQt/xo1bois/JewzxFA55rtjef1UInNjdp46qg4cABtw==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=DA8GOM1O; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::a2d"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::a2d; helo=mail-vk1-xa2d.google.com;
 envelope-from=hfranco@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=DA8GOM1O
Received: from mail-vk1-xa2d.google.com (mail-vk1-xa2d.google.com
 [IPv6:2607:f8b0:4864:20::a2d])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0F1D0408BD
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 21:54:21 +0000 (UTC)
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-5e9616ae981so297326e0c.3
 for <u-boot@lists.u-boot-project.org>; Fri, 16 Oct 2026 14:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1792187660; x=1792792460;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+lDT/F7D1EU0AN08t8QCFgz6smM4tOE2FK6QMBOjypM=;
 b=DA8GOM1O1lY7ws2k8AxuoW9fM9E9tcgYzIjNXo3p18fg/vQL2IZpResDj69Q8GaKvg
 9kF94S3NQB7aU0dy+qxBLG85AHbm5EXUUCalWCxtH5/f5sY/qoEed4AsYsguJtLgf/xG
 k3JC3hKQZ0YQ9SBqrFi8cgwsHEnQQ9l5sbv7IK6NnfpPOVjWvmhAgWU9UngMOOqX1x3K
 zcrUqF4ArMx525chc9qpcmDBkiu82Itrr/DMrgVz9fbbob2KHRGLWEsLoGt7xsxzW+GO
 NdmSG1ew8vJe41iuKQbJlWWSHM9ClTOIA4MAP9Dsql1Bgh8H95XLLP+VA9rGmatGy3wr
 C2Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792187660; x=1792792460;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+lDT/F7D1EU0AN08t8QCFgz6smM4tOE2FK6QMBOjypM=;
 b=vRbHTkNdcBWr0mVmuk74Wvw47HLB2zuNobATMts/JLhtqo2A1xtCOFujLqdP8oyKbU
 i0kRmLDgCwO//AgEzr35eWiNbmxWlEYkPu42m9FI6eQrgMH96y6CTq4RZPRwa+a7f8fL
 AancLLkZog0AbjdLInIIq9EARDqNFPKqQx44yDolYdSLF5RkakK2ejHsRXSN/6DJbunw
 wGofP+wwghfklpu3a7N17YBD6MEVn8mgV25jXBG/lDs8ABZxu2nmQS3sBX7uG4+kedfg
 8GpjTDvzUQ7Idc+K38D97somfhK4nV+k+UagQUWXamq6FBqXjjdqx54qizDjvENqRqYS
 9jQg==
X-Gm-Message-State: AFq9FYIDV1P6nW8Ti7aM/YrXHk3q90J0UPc/iN+TdDTFoCnOrdKIsTqN
 RnNgKZAAuKmSLPva8FwLviO3MZmovz0Sgcrfhmjun7TZ+VuM+qx6qfkYDQ48EEBquD0=
X-Gm-Gg: AYBFou3wJzN1aT8UJ4crQlS6+v/mDAwMypX6cOCgmXPa8mJqHqx+iNOZW5yYUfCqN7y
 0uQTuRvY0cwxilMkAHDQHXeNBNFonB1CMpHUPAbiAb138PD3eya/f2xqRhpHzI+uUwN/3foN57Y
 M1Wc25ZbBgO5xJsY6EtLLsUcfzybXnmlJ9bxP0rvi85GyR+V/6Nf1f/JrAIKIIS7jDUdNonNo2i
 Jo5Fa3NKSOHOtmyAn1u9eIBw9mTpmOsWyhaApxUqcy9+Am/ZlohuTCAT50WcnlVN/wUaGtVHUDa
 6JRLFqFyg8gqikDa/8bsuTYRnzQqHAu3CrMiTYJmYWYCq5gfrfTty/KTG1E/b2SVJJF8MtcBR2A
 zJ61cWMI3M8P73DVy7/9dCEqtpayIYJ+CDlfSdmTTdoyreBY3+GrWQuH0Br7g7gHuCk8iiRn90s
 8PuJRIElvvlchdaPwI4s2gs7ZbijdJQr68kKdXlsNZsCzAQLg3uIOLgFTcJS/7LJP0kYZqJyor0
 9d9eeUzc5AjEYnKoleN1wpFUt4w5cWm
X-Received: by 2002:a05:6122:398b:b0:5da:364d:77a7 with SMTP id
 71dfb90a1353d-5eaaa37417cmr646737e0c.7.1792187660424; 
 Fri, 16 Oct 2026 14:54:20 -0700 (PDT)
Received: from hiagonb ([2804:14c:4c5:8bf0::33ca])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5ea9b518bc8sm2584664e0c.11.2026.10.16.14.54.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2026 14:54:19 -0700 (PDT)
Date: Fri, 16 Oct 2026 18:54:12 -0300
From: Hiago De Franco <hfranco@baylibre.com>
To: =?utf-8?Q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?=
 <jpaulo.silvagoncalves@gmail.com>
Cc: u-boot@lists.u-boot-project.org, Yao Zi <me@ziyao.cc>, 
 Tom Rini <trini@konsulko.com>, Sumit Garg <sumit.garg@kernel.org>, 
 Gui-Dong Han <hanguidong02@gmail.com>, Joshua Milas <josh.milas@gmail.com>, 
 Chen Wang <chen.wang@linux.dev>, Inochi Amaoto <inochiama@gmail.com>, 
 Lukasz Majewski <lukma@nabladev.com>, Peng Fan <peng.fan@nxp.com>,
 Tim Ouyang <tim609@andestech.com>, 
 Leo Liang <leo.liang@sifive.com>, Raymond Mao <raymond.mao@riscstar.com>, 
 Michal Simek <michal.simek@amd.com>, Yixun Lan <dlan@kernel.org>, 
 Andrei Lalaev <andrey.lalaev@gmail.com>, E Shattow <e@freeshell.de>,
 Zhuxu Ran <zhuxu_ran@zohomail.com>
Subject: Re: [PATCH 0/4] board: sophgo: Add support for Milk-V Duo S
Message-ID: <atKbnMtM_oA6srZF@hiagonb>
References: <20261016-upstream-v1-milk-duo-s-v1-0-e4bf386eea2d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261016-upstream-v1-milk-duo-s-v1-0-e4bf386eea2d@gmail.com>
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

Hi João,

On Fri, Oct 16, 2026 at 04:52:30PM -0300, João Paulo Gonçalves wrote:
> This series adds support for the Milk-V Duo S, a development board based
> on the Sophgo SG2000 SoC with 512 MiB of RAM. The board uses the
> upstream Linux devicetree via OF_UPSTREAM.
> 
> The first two patches cherry-pick the SG2000 dtsi and the Duo S
> devicetree from upstream v7.3-rc1.
> 
> The Duo S gets its own board directory, based on the Milk-V Duo 256M
> one. Apart from the devicetree, the two boards share almost all of their
> configuration. However, they use different SoCs (SG2000 vs. SG2002), so
> the Duo S is not treated as a variant of the Duo 256M.
> 
> Hiago and Andrei reviewed these patches internally before submission,
> hence their Acked-by tags. Since they already work with these boards,
> they have agreed to maintain the Duo S support.
> 
> Tested on a Milk-V Duo S.

Thanks for the series. As I reviewed earlier, it looks good to me.

I will add Zhuxu Ran to CC since maybe he is interested as well. 

+CC: Zhuxu Ran <zhuxu_ran@zohomail.com>

Link: https://lore.kernel.org/u-boot/20261016-upstream-v1-milk-duo-s-v1-0-e4bf386eea2d@gmail.com/
> 
> ---
> Joshua Milas (2):
>       riscv64: dts: sophgo: add SG2000 dtsi
>       riscv64: dts: sophgo: add initial Milk-V Duo S board support
> 
> João Paulo Gonçalves (2):
>       clk: sophgo: cv1800b: Add SG2000 compatible string
>       board: sophgo: Add support for Milk-V Duo S
> 
>  arch/riscv/Kconfig                                 |   4 +
>  board/sophgo/milkv_duo_s/Kconfig                   |  30 +++
>  board/sophgo/milkv_duo_s/MAINTAINERS               |   8 +
>  board/sophgo/milkv_duo_s/Makefile                  |   6 +
>  board/sophgo/milkv_duo_s/milkv_duo_s.env           |   8 +
>  configs/milkv_duo_s_defconfig                      |  43 ++++
>  doc/board/sophgo/index.rst                         |   1 +
>  doc/board/sophgo/milkv_duo_s.rst                   |  86 ++++++++
>  drivers/clk/sophgo/clk-cv1800b.c                   |   1 +
>  .../src/riscv/sophgo/sg2000-milkv-duo-s.dts        | 244 +++++++++++++++++++++
>  dts/upstream/src/riscv/sophgo/sg2000.dtsi          |  53 +++++
>  include/configs/milkv_duo_s.h                      |  12 +
>  12 files changed, 496 insertions(+)
> ---
> base-commit: 8d534cec0cc0109a37c0ded8854da03f1526dc0e
> change-id: 20261014-upstream-v1-milk-duo-s-c4d2935c4298
> 
> Best regards,
> --  
> João Paulo Gonçalves <jpaulo.silvagoncalves@gmail.com>
> 

Best regards,
-- 
Hiago
