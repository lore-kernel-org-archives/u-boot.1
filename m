Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A475606A31A
	for <u-boot@archiver.kernel.org>; Thu, 29 Oct 2026 09:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=hdSRUfx5;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RJqqPWX8
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E111180F7A;
	Thu, 29 Oct 2026 09:25:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id yfttWfMAmkMT; Thu, 29 Oct 2026 09:25:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 47E4C80E78
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793265944;
	b=YG60cwF6DjeE1HmsDLk5kbr85fwDEzzl7PlcF4G7Q2eaylYFytWa33cL+EAZKnEcHVsp
	 zZKY9tFDCzeykRwdlFMJL/lns4zde1Yd7B4lHCQ/CGaX7XA8/Eq3ehzU7cS0xJ8lqLQIs
	 dVS00DgzU5PJawUh+ALbwsaz5L5/9D8SFpuoJ021f06b3KVO1IVCXIxF5DC+Twk2hQzH3
	 8qAqDdjCGMYQN7czJIea7UB530xpG9GNXyc1/i3jjmhwyUjTwvrnyViAb2uTbqvRnwqb9
	 wQgwX1BhaAhnbe/xnz3B4WQIR8G7E8FZji5cTjZDyjnIu/M2lODnA5reIOUlcARJAXw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793265944;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=y7mb/0rjfez8iCgWE/F0Pi/ul942LvSx2kEBbnqR0JI=;
	b=SN0JLx3iOqIIh6OccjLtX/CDeEQZUjSTfnrlpNQc36uROWCKO7WaW85SdzUgjkBfhZNY
	 RmLLQ8icGko0PPNhiOlknEzNt0OIYmZSGl9qDGtfs90MtTpn4zlDPNEY8lYjCO9V8c/7E
	 tIfFhFkWb7SetNRgE3k1ZlKbRwm3fL85rTfdAtgHTZKTZOBWSmMt6NL4yTICzGsKFhzKF
	 30AX5j7yQN4YCUDrStvCW65Idg33BbXgabxxNhbuwEs7Fx6YGRn0KzcDOzq0Nnf1/5ORD
	 EAwAeEfKUsbo8WsKMPlTtU1ZdiIjsp3AySdKKFexkP5Tp6tTawaR+532oW6fRRwXP6g==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RJqqPWX8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793265944;
	bh=y7mb/0rjfez8iCgWE/F0Pi/ul942LvSx2kEBbnqR0JI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hdSRUfx5RNTtl5ywM0QJwIaowvs5yGBQZrAHf8xhWGO12Rdla300g1p5mPo3PgxE0
	 WKO5zmMncqU6jmVoUDq8u2RUaYXITuERgSOCKgA50yoBQ54qM0zs1jk1/gzKVL/JSx
	 FimkJPLAVnPd/3JodLXU0R2FMjmKvmO8j4FXm1LeIo34vYD2Fu69dojnWt0pNMOeFw
	 2H3OzsEYDWqQ7l687v9FaNCpOZgHbJuk3jo2rd1mwzkdGC5jLhwkVsALxdMMVIVFNA
	 qsIv1SpQyQzg2N4mhYjtB3bcwZp1iEOTleA9K8TKsJOUBJn33YO67DYeYa8kUyvTVv
	 z3XIrq6kgIWhg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 47E4C80E78;
	Thu, 29 Oct 2026 09:25:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id E9D2A4BC
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 09:25:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DAFDB80E78
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 09:25:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id i80KkuJSVLkI for <u-boot@lists.u-boot-project.org>;
 Thu, 29 Oct 2026 09:25:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 1D91D80E34
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::235"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793265941;
 b=eCNgBg1kw2bQiY7bcyVc/jPMbxUjK7rSOyKiCI+lggHY651vOtWc0FxyX4kl7rgZsNT3
 6qCSWOrJp2SEsfPsnT3v9LuzG391yTMxZ0F7HyS0+7a1JDhBpcPMACvAfVKitLFYLo0mf
 edFgIbfkYAFbYMn0Ks4iCN8uhbQgBTtnoaDgVKpUZwJmfB4JMwRMiMuwU6xpalZCmRYVf
 LcS9a1DcQcu8JffeJ4DxVLgaLT/vVm9duvTLRRMQ4etQABqkagXnRXcelvDqLjDFeJsAP
 cIGc2bv+a9HvY5v/dTbRBqvjDLedcWtbVIZokO5Z3rtZI9XlZHY4SNsf5QlXbUvIeqg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793265941;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=y7mb/0rjfez8iCgWE/F0Pi/ul942LvSx2kEBbnqR0JI=;
 b=J0ETGNpMgIFYRIu4VRun8JkitC/Ly2TFLlAmrADLql7nzLDL0e+2DYY4mMK1gMTQNG7N
 u7hvY00XJ4zPuhYMi5Yjqw45gvHbjja4CiPfz3/KoLzJNjz0jLf8vojDraz+zeFlgSrHF
 exX48rD+l7SyLT3LsEUH0Ot+yGAkl9Hf+HvD6mINMmZtrR3YWQUQd3e4TwmAxGJoIGvFE
 8QWDAORDhNxXVSe8WNFTEby4Ih0eNEJ7M6rzSHfFZfP3C0WPvD9ejwKdvBrBrPhvXICmG
 iU0wcf4CbLTye6pRBGd+yQ3b9ULwqRVZlD1bgqbEndltRE+m9rJfzUv1xdTUVL1yNkg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=RJqqPWX8; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::235"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::235; helo=mail-lj1-x235.google.com;
 envelope-from=pbrobinson@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=RJqqPWX8
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com
 [IPv6:2a00:1450:4864:20::235])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1D91D80E34
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 09:25:40 +0000 (UTC)
Received: by mail-lj1-x235.google.com with SMTP id
 38308e7fff4ca-3ac97e45a79so13940661fa.3
 for <u-boot@lists.u-boot-project.org>; Thu, 29 Oct 2026 02:25:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793265938; cv=none;
 d=google.com; s=arc-20260327;
 b=ckI3424Z9Vr2wVmozsp4xv0vMe0AfPv1An79q7K2Xwdj3RIoXhklDLGO44Eud93C1v
 rHfcqMKIANXCtRUlwZQxhVXDiNMavC90vjEbjnL8EhYlCaxhpI6kB5JEQ/JwpN8zPudP
 IXSQjBnvJpKbCOAEEj9uTZhNXxQ+oVS7UOY8/tNTqojEKGDZt6pxPg6t9XsPqWX4Gq7o
 V1gxLB1pQSUqbB0ETimw+2p9pc0RNchDYjo79P/0ksUqoYzlMJKHnfrS5VHqsbIa/s/f
 nc2R1TN2paX3AS8nnKKvHp9oDCoy2hUN/TvsbJSIzf+JAiEsctneG+BBzDbDB8YQsR7o
 CR1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=y7mb/0rjfez8iCgWE/F0Pi/ul942LvSx2kEBbnqR0JI=;
 fh=PrVR0M/BKk1EN2cyk13baNjzK0Djxgb/yD8irO2S578=;
 b=gS4U6N3zNrYaqKIs8Sm+eTILEmrO41s7K2FlV0PCnuYrdg+hzMxzUTS0KHt/lcOxQC
 SlaVghwDCgeEA4K1pLMYCx6gNDtALtxTByvKKhgYtmgf4ntf59JcTuNFT2q2bxdA5rYr
 sv88BVbEwNF0xl3kQhb/pnQE56Tonsjtui989vjssuetxc0jSkfmTHsiPTEMG4/IclKW
 L/JdUTJP8N8T6i1o3M+TXhhM/s9h/k1nL/gxySwz8edR7AByABQ6TYUFMbfTO434kpAa
 jpEBob1H4H80jXphu4QTrN04GMD2efA3Gylmd1vKnBTw9jd96/ov0jEOrovObKaNJwAb
 eV7Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793265938; x=1793870738;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=y7mb/0rjfez8iCgWE/F0Pi/ul942LvSx2kEBbnqR0JI=;
 b=RJqqPWX8ZG3XnAKaf7veRGCV9dQ/FCQhzyLcTiGV+/Vc0SxZIpXARDvqq2ZCjHDMxv
 WnkwH9w4HQZr97apeG+lsyKcqdAQw9TdyDYAr6mIZ+viW9AvxKjQhrcYNXQzth0JTvyc
 41WgI8J2fU3GrpMElIRd6bDCVcIxBGMECQOL9oTBnIoaEQGpGp2ZiX/O2uj2N5jDvR5O
 HqQsxE90Ijg4lbHzjlPYouFzOFcnpUL7l9xns+TTuWxUjZJHVU9gjDlyXeqINJfTfLcD
 0lLGgKEoZZKa+8lFi39LeI4Nx5AcoyfWsGl/TaEvc2jtwUgHPRv5FshXt/tNcvV2Nlsc
 iW5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793265938; x=1793870738;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=y7mb/0rjfez8iCgWE/F0Pi/ul942LvSx2kEBbnqR0JI=;
 b=RLHS3YPhpArhnwcGxRGBLNl8/fr0xXqx10jPHvDE4dDzWhwnwz7L0K/USZ0bnpMAzc
 mmgACVjdHM1QOhXcy+0trdwyBs1dyYsZS/lliJEtK0e6GgEHyR51HvxfTNln22g9qMhC
 MYU8qYiwR5VgK1Mdc9rXXlI4SPeb+8B0BpLWL50GkTz7DfsE4mlbmuMgppx7KkoTmuJ4
 BI/iCOfOmHWv2vyK3cN5mwousnao8mtwBbwJYu+7TnQvIsa2RNCz74px+vAmcWwvbKOs
 Q3wXLgVjWqQepvMYLsovmutx90IRdL51KpNtiE3Q517L3fhKCgAF0E7xc6p204S8gUNp
 J+4g==
X-Gm-Message-State: AFq9FYJLJUkp+o1M0TsOi/tIwOZs62GBJ+EqZPUghnffjZ8sQ7z9JbiF
 7SfE75FjoabzC5//ouwMsM/PCdc6wVIkXH0x3lSA4yuQGkDfIrrXnvx4+tWDU0D0FQMasrZQIva
 VE2oJp8PSWVZhE4/6CXGGOkjyeBX4RWU=
X-Gm-Gg: AYBFou0zVXYYOip23hacIC/grX4bKJgCtcWNCmQJVtMxTA2LdPcgnFn3eXRcqcLG5l5
 sDjN44gpTG2JYh+9a/spzg+c3aONqdi99K12nqz3jz0cSqLme77o1epE9qe3y/hTp9pCPzGqohr
 9xG/sHjmG4c93zEUEVqXybY0p5aMAM+44pCRfm8G/2TStXEx16DVADj3jl7cu7tpce8sRLnLdnh
 RGtrWAqJBpM/WgC5Q7UZQ9jWJx5wBl2lSc50L8uDEx5xeOFMpG0++HqOKD2uEXQ3T4k5G/Yfmot
 c2jyE/otD8GFoYsMY1S28MQmrv3o1TVDeZxwD993UTk8UOsnvoSTcI+095x7NnL4g9m60ZJimhb
 bUs0EIxEyhzjE8EDk93lxdTGkDkx4sev9GtdE8eJyn9E+0AGokTALy76f9lDedukup105fj7koz
 oRFo05AwkGdpKgR4t36Gh7HAcgttY3pyWDGBlQhoZLODTDqFHvKBaD1QvJJGDtUtstWoieCbAw6
 HB5g1nZqyGaUIyenxhr5Cmh9FnLrSGnMUA=
X-Received: by 2002:a2e:a556:0:b0:3a9:811d:3a58 with SMTP id
 38308e7fff4ca-3ac9cf24d6dmr10998961fa.14.1793265937903; Thu, 29 Oct 2026
 02:25:37 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261028100259.2491887-1-akashn@marvell.com>
In-Reply-To: <20261028100259.2491887-1-akashn@marvell.com>
From: Peter Robinson <pbrobinson@gmail.com>
Date: Thu, 29 Oct 2026 09:25:23 +0000
X-Gm-Features: AclHuK824RkeAlFCA6RjKwB83C6WHoW2e2J2iCeIXi8HmgsJmGXGy_hUX24QsAc
Message-ID: <CALeDE9MH_tPQi+vHBis3jQVAUuCQLRU7a_GXPt_gOzYz1Y7k=A@mail.gmail.com>
Subject: Re: [PATCH RFC 0/2] net: pcs: Add generic PCS interface and Synopsys
 DW XPCS driver
To: Akash Nair <akashn@marvell.com>
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com, 
 jerome.forissier@arm.com, rkannoth@marvell.com, naveenm@marvell.com
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-1.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_GMAIL_RCVD,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Akash,

> This RFC adds an interface for Ethernet PCS (Physical Coding
> Sublayer) devices and a driver for the Synopsys DesignWare Ethernet
> PCS (DW XPCS) that implements it. I would like feedback on the
> interface and on how the driver is structured before I post the MAC
> driver that uses it.

I would typically expect a driver, even if explicitly labelled not
ready for merge, to enable people to see how this would work.

> Background
> ----------
> On SoCs with a DW XPCS between the MAC and the SerDes, the MAC driver
> has to configure the PCS and read back its link and auto-negotiation
> state to bring up 1000BASE-KX, 10GBASE-R and 10GBASE-KR links in
> U-Boot, for example for network boot.
>
> U-Boot has no reusable driver for this IP.

Do you happen to know if there's other drivers in U-Boot currently
that are poking the PCS interfaces directly? Not asking you to convert
them, more just wondering if it's been hacked up elsewhere.

> What is in the series
> ---------------------
>   1/2 net: pcs: Add generic PCS interface
>   2/2 net: pcs: Add Synopsys DesignWare XPCS driver

Is the DW driver based on the proposed Linux driver for this? [1]

> Patch 1 adds include/pcs.h. Patch 2 adds the driver in
> drivers/net/pcs/ with its Kconfig and Makefile, and hooks them into
> drivers/net.
>
> Architecture
> ------------
>   +--------------------+
>   | MAC driver         |  (follow-up patch, not in this series)
>   +---------+----------+
>             | pcs_set_config()  pcs_get_state()  pcs_disable()
>             v
>   +--------------------+
>   | include/pcs.h      |  patch 1: struct pcs_ops, pcs_config,
>   |                    |           pcs_state
>   +---------+----------+
>             | ops of the PCS device
>             v
>   +--------------------+
>   | pcs-xpcs.c         |  patch 2: UCLASS_MISC, "snps,dw-xpcs"
>   | indirect window:   |  page register + register offset
>   +---------+----------+
>             | MMIO  reg-names = "indirect", reg-io-width = <4>
>             v
>   +--------------------+       +--------------+
>   | DW XPCS            |<----->| PMA / SerDes |<--> link partner
>   +--------------------+       +--------------+
>    1000BASE-KX: C37 AN   10GBASE-R: no AN   10GBASE-KR: C73 AN
>
> Interface (patch 1)
> -------------------
> include/pcs.h defines struct pcs_ops with three operations, and an
> inline wrapper for each one. A wrapper returns -ENOSYS if the driver
> does not provide the operation.
>
>   pcs_set_config()  select the interface mode, the auto-negotiation
>                     type (none, Clause 37 or Clause 73) and the
>                     speed, using struct pcs_config
>   pcs_get_state()   report link, auto-negotiation complete and speed,
>                     using struct pcs_state
>   pcs_disable()     stop auto-negotiation and power the PCS down
>
> Semantics:
>   - set_config() can be called again later, including after
>     pcs_disable(). If it fails, the PCS is left unconfigured.
>   - get_state() reports the speed as soon as the PCS is configured,
>     not when the link comes up. A powered down or unconfigured PCS
>     reports link, an_complete and speed as 0.
>   - A negative return from get_state() is an error, for example a
>     failed Clause 73 negotiation.
>   - Calling pcs_disable() again has no effect.
>
> Driver (patch 2)
> ----------------
> drivers/net/pcs/pcs-xpcs.c is a driver model driver for the
> "snps,dw-xpcs" compatible. It is a UCLASS_MISC device and is enabled
> with PCS_XPCS, which depends on MISC.
>
> The XPCS registers are Clause 45 registers in the PMA/PMD, PCS, AN and
> vendor MMDs. They are reached through the memory mapped indirect
> window: the driver writes the page number of the register to the page
> register of the window, then accesses the register at its offset in
> the page. The selected page is cached to avoid redundant writes.
>
> At probe the driver waits for the PCS to come out of reset and checks
> the Clause 45 device ID. It does not configure a mode. The MAC driver
> does that with pcs_set_config(). The driver checks the whole request
> before it touches the hardware, so a bad request does not leave the
> PCS half configured. It then stops auto-negotiation, programs the
> mode, power cycles the PCS to latch it, and starts auto-negotiation if
> the mode uses it.
>
> Supported modes:
>   1000BASE-KX  Clause 37 auto-negotiation
>   10GBASE-R    fixed speed, no auto-negotiation
>   10GBASE-KR   Clause 73 auto-negotiation
>
> pcs_set_config() accepts only these combinations. Anything else is
> rejected before the hardware is touched, with -EOPNOTSUPP for a wrong
> auto-negotiation type and -EINVAL for a wrong speed or interface.
>
>   iface         an_mode        speed_mbps
>   1000BASE-KX   PCS_AN_C37     0 or 1000
>   10GBASE-R     PCS_AN_FORCED  10000 (required)
>   10GBASE-KR    PCS_AN_C73     0 or 10000
>
> Auto-negotiation completion is polled from pcs_get_state(). The link
> status bit is latched low, so it is read twice and the second value is
> reported. For Clause 73, pcs_get_state() returns an error if the link
> partner cannot do 10GBASE-KR or uses Next Pages.
>
> Devicetree
> ----------
> The driver uses the existing "snps,dw-xpcs" binding from dts/upstream
> (Bindings/net/pcs/snps,dw-xpcs.yaml), so no binding change is needed.
> Only part of the binding is implemented. reg-names must be "indirect",
> the window must be at least 1 KiB, and reg-io-width must be <4>. The
> binding default of 2 is rejected, so the property cannot be left out.
> The clocks and the interrupt are not used. The driver does not enable
> clocks, so they must already be running when it probes. The gen*-PMA
> compatibles are not matched.
>
> Example node:
>
>   pcs@1f05d000 {
>           compatible = "snps,dw-xpcs";
>           reg = <0x1f05d000 0x1000>;
>           reg-names = "indirect";
>           reg-io-width = <4>;
>   };
>
> Origin of the code
> ------------------
> Some parts of the driver are influenced by the Linux XPCS driver
> (drivers/net/pcs/pcs-xpcs*.c).
>
> Design choices
> --------------
> UCLASS_MISC: a PCS is a UCLASS_MISC device and the MAC driver is
> expected to get it by phandle. This is what the Airoha PCS driver and
> airoha_eth do today. A dedicated UCLASS_PCS would be cleaner, but I
> left it out of this series on purpose to keep the scope small.

Can you explain why you chose to depend on UCLASS_MISC for the
functionality other than scope? It seems like
Hi Akash,

> This RFC adds an interface for Ethernet PCS (Physical Coding
> Sublayer) devices and a driver for the Synopsys DesignWare Ethernet
> PCS (DW XPCS) that implements it. I would like feedback on the
> interface and on how the driver is structured before I post the MAC
> driver that uses it.

I would typically expect a driver, even if explicitly labelled not
ready for merge, to enable people to see how this would work.

> Background
> ----------
> On SoCs with a DW XPCS between the MAC and the SerDes, the MAC driver
> has to configure the PCS and read back its link and auto-negotiation
> state to bring up 1000BASE-KX, 10GBASE-R and 10GBASE-KR links in
> U-Boot, for example for network boot.
>
> U-Boot has no reusable driver for this IP.

Do you happen to know if there's other drivers in U-Boot currently
that are poking the PCS interfaces directly? Not asking you to convert
them, more just wondering if it's been hacked up elsewhere.

> What is in the series
> ---------------------
>   1/2 net: pcs: Add generic PCS interface
>   2/2 net: pcs: Add Synopsys DesignWare XPCS driver

Is the DW driver based on the proposed Linux driver for this? [1]

> Patch 1 adds include/pcs.h. Patch 2 adds the driver in
> drivers/net/pcs/ with its Kconfig and Makefile, and hooks them into
> drivers/net.
>
> Architecture
> ------------
>   +--------------------+
>   | MAC driver         |  (follow-up patch, not in this series)
>   +---------+----------+
>             | pcs_set_config()  pcs_get_state()  pcs_disable()
>             v
>   +--------------------+
>   | include/pcs.h      |  patch 1: struct pcs_ops, pcs_config,
>   |                    |           pcs_state
>   +---------+----------+
>             | ops of the PCS device
>             v
>   +--------------------+
>   | pcs-xpcs.c         |  patch 2: UCLASS_MISC, "snps,dw-xpcs"
>   | indirect window:   |  page register + register offset
>   +---------+----------+
>             | MMIO  reg-names = "indirect", reg-io-width = <4>
>             v
>   +--------------------+       +--------------+
>   | DW XPCS            |<----->| PMA / SerDes |<--> link partner
>   +--------------------+       +--------------+
>    1000BASE-KX: C37 AN   10GBASE-R: no AN   10GBASE-KR: C73 AN
>
> Interface (patch 1)
> -------------------
> include/pcs.h defines struct pcs_ops with three operations, and an
> inline wrapper for each one. A wrapper returns -ENOSYS if the driver
> does not provide the operation.
>
>   pcs_set_config()  select the interface mode, the auto-negotiation
>                     type (none, Clause 37 or Clause 73) and the
>                     speed, using struct pcs_config
>   pcs_get_state()   report link, auto-negotiation complete and speed,
>                     using struct pcs_state
>   pcs_disable()     stop auto-negotiation and power the PCS down
>
> Semantics:
>   - set_config() can be called again later, including after
>     pcs_disable(). If it fails, the PCS is left unconfigured.
>   - get_state() reports the speed as soon as the PCS is configured,
>     not when the link comes up. A powered down or unconfigured PCS
>     reports link, an_complete and speed as 0.
>   - A negative return from get_state() is an error, for example a
>     failed Clause 73 negotiation.
>   - Calling pcs_disable() again has no effect.
>
> Driver (patch 2)
> ----------------
> drivers/net/pcs/pcs-xpcs.c is a driver model driver for the
> "snps,dw-xpcs" compatible. It is a UCLASS_MISC device and is enabled
> with PCS_XPCS, which depends on MISC.
>
> The XPCS registers are Clause 45 registers in the PMA/PMD, PCS, AN and
> vendor MMDs. They are reached through the memory mapped indirect
> window: the driver writes the page number of the register to the page
> register of the window, then accesses the register at its offset in
> the page. The selected page is cached to avoid redundant writes.
>
> At probe the driver waits for the PCS to come out of reset and checks
> the Clause 45 device ID. It does not configure a mode. The MAC driver
> does that with pcs_set_config(). The driver checks the whole request
> before it touches the hardware, so a bad request does not leave the
> PCS half configured. It then stops auto-negotiation, programs the
> mode, power cycles the PCS to latch it, and starts auto-negotiation if
> the mode uses it.
>
> Supported modes:
>   1000BASE-KX  Clause 37 auto-negotiation
>   10GBASE-R    fixed speed, no auto-negotiation
>   10GBASE-KR   Clause 73 auto-negotiation
>
> pcs_set_config() accepts only these combinations. Anything else is
> rejected before the hardware is touched, with -EOPNOTSUPP for a wrong
> auto-negotiation type and -EINVAL for a wrong speed or interface.
>
>   iface         an_mode        speed_mbps
>   1000BASE-KX   PCS_AN_C37     0 or 1000
>   10GBASE-R     PCS_AN_FORCED  10000 (required)
>   10GBASE-KR    PCS_AN_C73     0 or 10000
>
> Auto-negotiation completion is polled from pcs_get_state(). The link
> status bit is latched low, so it is read twice and the second value is
> reported. For Clause 73, pcs_get_state() returns an error if the link
> partner cannot do 10GBASE-KR or uses Next Pages.
>
> Devicetree
> ----------
> The driver uses the existing "snps,dw-xpcs" binding from dts/upstream
> (Bindings/net/pcs/snps,dw-xpcs.yaml), so no binding change is needed.
> Only part of the binding is implemented. reg-names must be "indirect",
> the window must be at least 1 KiB, and reg-io-width must be <4>. The
> binding default of 2 is rejected, so the property cannot be left out.
> The clocks and the interrupt are not used. The driver does not enable
> clocks, so they must already be running when it probes. The gen*-PMA
> compatibles are not matched.
>
> Example node:
>
>   pcs@1f05d000 {
>           compatible = "snps,dw-xpcs";
>           reg = <0x1f05d000 0x1000>;
>           reg-names = "indirect";
>           reg-io-width = <4>;
>   };
>
> Origin of the code
> ------------------
> Some parts of the driver are influenced by the Linux XPCS driver
> (drivers/net/pcs/pcs-xpcs*.c).
>
> Design choices
> --------------
> UCLASS_MISC: a PCS is a UCLASS_MISC device and the MAC driver is
> expected to get it by phandle. This is what the Airoha PCS driver and
> airoha_eth do today. A dedicated UCLASS_PCS would be cleaner, but I
> left it out of this series on purpose to keep the scope small.

Can you explain why you chose to depend on UCLASS_MISC for the
functionality other than scope? I think I would sooner see a
UCLASS_PCS now rather than a lot of driver duplicated work that will
need to be fixed later. Maybe work with the Airoha maintainer to
convert that driver as an example, the Airoha support is quite new.

> No in-tree user yet: the MAC driver that calls this interface will
> follow as a separate patch in about a month. Until then PCS_XPCS is
> not selected by anything and not enabled in any defconfig. This is
> why this is an RFC.
>
> Questions for reviewers
> -----------------------
>  1. Is UCLASS_MISC with the ops in include/pcs.h acceptable as a
>     starting point?

I would sooner we go straight to UCLASS_PCS, it might be a bit more
work now, but will be less maintenance overall.

>  2. Are struct pcs_config and struct pcs_state enough for other PCS
>     drivers, or is something missing?

I would like to see what other drivers poke the PCS stuff in tree as I
doubt this is just Airoha.

>  3. Auto-negotiation completion is polled from get_state() and the
>     interrupt is not used. Is that fine for U-Boot?

I suspect it's probably fine, does get state use the event loop interface?

> Testing
> -------
> Not tested on hardware yet.
> Build tested with CONFIG_PCS_XPCS=y on qemu_arm64.
> checkpatch.pl --strict reports no errors.

I would like to see actual tests as part of the patch series.

> Not done

Are you intending to do this list below? It's not clear.

> --------
>  - Interface modes other than the three above. More modes are planned
>    once this is approved.

Please outline where you expect those to go, it helps provide context
to the actual reviewers rather than telling a small part of the story,
it also may show that a PCS uclass is more appropriate than using
misc.

>  - Clause 73 Next Pages: a link partner that uses them is rejected
>  - Register access over MDIO and the "direct" mapping
>  - Clocks and the interrupt from the binding
>  - PMA/SerDes initialisation: not done by this driver, it must be set
>    up before pcs_set_config() is called

How is that done? How is it documented? Again the sample driver would
likely show this.

>  - SPDX tags and a MAINTAINERS entry (checkpatch warnings)
>  - Sandbox emulation and a dm test
>  - A dedicated UCLASS_PCS

Peter

[1] https://lwn.net/Articles/1099457/
