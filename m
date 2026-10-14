Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC5ACCC6B1A
	for <u-boot@archiver.kernel.org>; Wed, 14 Oct 2026 11:10:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 557DC80D39;
	Wed, 14 Oct 2026 11:10:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4OZ79NRZ3Pji; Wed, 14 Oct 2026 11:10:05 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 8771B80D47
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791976205;
	b=m3Xt+t+dHx2RnqccLIIMtlpeSzglcYMWce0tyLwx1a7XnTw3NDbE7vNmwLg0hMmYVBdN
	 1G3DSVQuzOZVE1tafF9WWnAcvgW1fKIvwAwO+2R+WR+YSpwjeYLgx662ldulBNjwubMan
	 MNBZ7v1OwZfGwyPXMz7OPfLA03eVcP2BQXqzdbJ+gDHO+Sgnd9SFUteBjWRdITihrzCsB
	 9FIA2dsimVp8dAlYiN0+22TAI7V3Wx7yIgEbSy0gbfV0oypuKoVFXPc+dDMpH1thsooHc
	 IcX4iwkNC/a/6qA9B+sEcfj6A26EIw8xjh2f+0RwJ+GMNbXQobE6Sn4t00+glHwcVnw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791976205;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=lG37fC/l/IUgEi4LpJbnD++16X8yCItJ1VmLYXEcQRE=;
	b=AE3i3DHaCVygSj3DIlM7omkmJhqxf+UV1DxPpB5oPEpOjs9TMkYC7NYv/Dm7uiQtsovY
	 GHnwS6K/ElEk9K6VFCxG0xzo/z6P/XDvTHK1HHS/GgFSlc0Yyu7dq3os7As9LHYhKD2tr
	 jqVkV99gcrFugG1UtZVoa1HP1ubxi5/ijbmodeqNgLaoNn14Jyn/3X6ieMrrcCvtonqf1
	 Wr/8Jlya7SWRBq9HktdW5iO0r/hjcfMyWi0Ikfp8B47YNL3Xadxv8gKJWHedVqoFdmFd+
	 2ANC1rOUtxXsmfeCVEsdsuk9QfwPmiQW15JY9nwFOnDTrDT2FxlurP3uBMBAzEN4cmg==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Hlm2Kjgr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791976205;
	bh=lG37fC/l/IUgEi4LpJbnD++16X8yCItJ1VmLYXEcQRE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cEpJRk1Aaon8X5lv4PoqCdjolQyVu7pVgf3epVLKHCkLOFexGkOtKvNbY4Daozn2y
	 TK58mIVO3qFWoIPpw5hs4HTALHHJFj7NwRjJI1/AyHi4itOdUhO1euGZhkVobEgQKE
	 /09EheS6Lm+AoIMI20FMqnsk+/Lf2lZDDR6CjXEOWJ5ZjQC3CqXctAXyc06VkOSJLn
	 J6Ll+nkx9Sby7cxAiEKBMAmGQ2Po+a30II81Wl4QzMKGwDhqUv9Pz42BoeQvHFoZ79
	 gxCKjfhJTcHhL8mqYqro1gsipZGrcVWIgjB6x4GljiRP/X9xkpQIy6SIJ1o6mSRxzS
	 Z/rf84vagFcYw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8771B80D47;
	Wed, 14 Oct 2026 11:10:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id E1A78105
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 11:10:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DEA2B80D2B
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 11:10:03 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id FMiMDI6SVUi8 for <u-boot@lists.u-boot-project.org>;
 Wed, 14 Oct 2026 11:10:03 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 042B180CEC
Authentication-Results: smtp1.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1791976203;
 b=n7aOSRUfe7jNfEedTP5GSl5qkOfwmB2SFcsNYrOTvecfLvZ6rVUVOMi4zbi+XB3f77Ax
 aR0glhT3c1nQJGhjAfFaUTpq1z+k2wij6LG0G3HwBtPI6iZTL9OhFRDsCEwLmbBBP0L/F
 ZkUY7p43B7Ri2rGaPnhf9g9QpIpJ3eCgrVuW6GCsyJqvQEFJpcZYoPgUoDliKPz8HutlX
 kwoty+EoV1VPiy6XP6J2iQx0XMe7a38bUdvaa62Mm5MWUu31bw2awSjb+suye00Nvw6G+
 /TtWxxFD58hBqg59rg90zog4CSBWoCEhYKxKXUpRy+qlwi+npug6ikstXLnYGrXRb4w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791976203;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=lG37fC/l/IUgEi4LpJbnD++16X8yCItJ1VmLYXEcQRE=;
 b=S7M+7ewlv0Gyg2zTf38922bPnW+Kj5U9bj2XrIW1+juQe3jzc5BG/K7m6yksvCnlYagI
 L+5DFB8p/pKJIw6Q06tcN4+xyGXEbpNu/Vm9UHxVv3M2y/IADLObO0yudMO0IdI91GLQx
 sOsz4HugGCuBasYmDZja67ouW1pgE2NMzsyqeFWKcfW6ONMj4XuobxglFyLrNY0O40iT0
 YMVD8eqG0Ch0/9lRyFgx0j0ugLQKbSfmTBWQf1rvT6Wh7AqckdOZVnqJIcUAL8qLpMOHa
 lEo6bHCBNXOpqNNaw/TO85QFqhiY53cs3OmXb0RlZfhbyB9T0HjGs5DGoiBWQBfK1UA==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmail.com;
 dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20251104 header.b=Hlm2Kjgr; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::32a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::32a; helo=mail-wm1-x32a.google.com;
 envelope-from=ghidoliemanuele@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20251104 header.b=Hlm2Kjgr
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com
 [IPv6:2a00:1450:4864:20::32a])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 042B180CEC
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 11:10:01 +0000 (UTC)
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4a1688d7769so7443705e9.0
 for <u-boot@lists.u-boot-project.org>; Wed, 14 Oct 2026 04:10:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791976200; x=1792581000;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=lG37fC/l/IUgEi4LpJbnD++16X8yCItJ1VmLYXEcQRE=;
 b=Hlm2KjgrQZtREKVKOKQC0SNUniu0yF76i79um0mO9E6U67McIeaw9AVP/g/Ex0RXq+
 sxVYnnPsukc7UuQFITi1C9ARjgq36/ZE43T3Hjy3oGOAsTcTyMjK3SR110iUcHn4qpLy
 sQ30FkORjeRDgYNS6NJgvm8FRJUotcfBAuxx62CQw8rVb4z25I1Lptdc+earJsr2AcvX
 HVB0vt8MdjRM1SgMDG2tVeoOhVp8RUYF+RAFGTEr3SkU6qRv4EWz7ZHsC+m9EKsoTqhb
 iHQVd4G0QXK9rpzfqd/qn5ze6DupaKsDBA2uKAbvkkP2L47yNeCDjjPZfIN6qaB872z3
 YSOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791976200; x=1792581000;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=lG37fC/l/IUgEi4LpJbnD++16X8yCItJ1VmLYXEcQRE=;
 b=HCqGJuvrGQsKFUts/WuyFBCRBsxHuVO8UtYRo6N2kLhIcNZEp/H7nGsfhCj1uhJc9g
 KfahBNW1zuEmE4YeMH17LOpKmsJ0BoXku3fjUMtrjJJw1v5/f7JWmG/sTOVi18gxkfGt
 8Db9aSB+ZX5BSs/+bOpyKnVQD+m0p2yG2/JquoEsWHrjizpkm6WCdyBRXdRAa7t24pcq
 VakO65KckhpHcE9Ua1HxW2+sILpO3OIPAube9ndlJ4RIZ1ncL/UuYuX1nViPw+nWHz91
 sAn/zb7kHGqy6fcJZ2T78Oh1NPsDDoVeiE6EsyXneeogSfEnGjZhxedHv4syaMI168D1
 fobw==
X-Forwarded-Encrypted: i=1;
 AKwUvBw8yncZlPiAbmm5X1oQydrCTn/JwRF07C53FkYqV4BGeIDBfmFcJS3l2MyUEkPedRxs5mzlwC8=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYIJlqPrevWNeXixud19df1tJfTCujTiI3jnlwesL9fB6V8hsRxO
 GlGb2MYIF0AK97PP1ltZhiqCtY2BiEwXj1N4if/zQWEIbs996Hndbqqg
X-Gm-Gg: AYBFou3TbglcGCkMLVnVh/xIcckxD9102hQEz+LHIWF4GSWM2h/FflKT2a7deU5gDRy
 YBOgZUbMuA6hyvqammtqAjeH6d0dQq/AoO4Dtjkc0ElLcc/bes0F76bIK7G2zdpLzYOFiuJ4ff2
 iNBRcCZGyC/bPYLITNvrkfVI7TTOnrey6s/SXxgQMh2w6Alkt5JeL93lbYF96WFPXZRvoPGQNSv
 Kv/yxaUNmnXMm8c0OTsu996qHo2wW2K743poCMfNUll4KqDaISXhfugfoD032pAGHiI/L0cyvhQ
 chUMXAzWWVkI6WeQR532Nb1CR0vpsDzytK/nHBFGvbGku6tDX8cdff0M2RtZKlTfVaQ1dLKNx0F
 TycIuHZUmZTbg0DRvpe89H/vgJBgMuN6VyhQY2WZEmAhCsiHgKX3Ud857RxEw6jMI+p7jcS+KDq
 snILyk51UtvG7NhFRbHbPQL9HhmGY67XOeiw0UNBa411S0VWDoiOuDqx94fs9A/EWtKhckNiYzZ
 p3JOGYYnE92FmdZboSqYU0652PUXxUqfGI7ZERriimgZzkEXaPeRgXchiygaw==
X-Received: by 2002:a05:600c:8216:b0:49d:34:420d with SMTP id
 5b1f17b1804b1-4a18e4b0465mr311571605e9.20.1791976199711; 
 Wed, 14 Oct 2026 04:09:59 -0700 (PDT)
Received: from [192.168.1.3] (host-80-180-152-220.pool80180.interbusiness.it.
 [80.180.152.220]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a18bf3e044sm423876805e9.14.2026.10.14.04.09.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 04:09:59 -0700 (PDT)
Message-ID: <34c2408b-66ab-4974-b1cb-ecdd7ac5e140@gmail.com>
Date: Wed, 14 Oct 2026 13:09:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] imx9: scmi: Move u-boot early MMU table to top 2MB
 of first 64MB DDR
To: ye.li@oss.nxp.com, festevam@gmail.com, u-boot@lists.u-boot-project.org,
 francesco.dolcini@toradex.com, emanuele.ghidoli@toradex.com
Cc: peng.fan@nxp.com, uboot-imx@nxp.com, alice.guo@nxp.com, ye.li@nxp.com
References: <20261014100915.3470159-1-ye.li@oss.nxp.com>
Content-Language: en-US
From: Emanuele Ghidoli <ghidoliemanuele@gmail.com>
In-Reply-To: <20261014100915.3470159-1-ye.li@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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



On 10/14/26 12:09, ye.li@oss.nxp.com wrote:
> From: Ye Li <ye.li@nxp.com>
> 
> The default u-boot early MMU table address is at CFG_SYS_SDRAM_BASE.
> The same address is used as alias target on Toradex's iMX95 boards in
> RAM-size probe. When a probe address aliases that location, the test
> temporarily overwrites an entry in the active page tables.
> 
> To avoid such overlap, move u-boot early MMU table to top 2MB of first
> 64MB DDR.
> 
> Signed-off-by: Ye Li <ye.li@nxp.com>

Reviewed-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>
Tested-by: Emanuele Ghidoli <emanuele.ghidoli@toradex.com>

