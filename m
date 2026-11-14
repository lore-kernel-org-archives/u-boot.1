Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67682606A329
	for <u-boot@archiver.kernel.org>; Sat, 14 Nov 2026 08:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=0+qQH/0u;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=dHCnxrEp
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DDA1C816E5;
	Sat, 14 Nov 2026 08:54:59 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 6fbtUD4A0MqV; Sat, 14 Nov 2026 08:54:59 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 08179816D8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794646499;
	b=UQ3UX9OMaoQgDAJQGUtBNj+fAAY3YgK9u0DRT0heAiibMoNnKgYjmgCuARBJH5bH23Nl
	 FbSekJXStaFjLi7hDSf6nclbmOhFq2PWPbRghGYJ/qYYivpTsw96VVcHJwx0GNmyBIqEQ
	 CKxkLCO1X3TBZQz8CWvC65CdYuzT44CFeZsRHKye0/ZVCL85At/jAZ/GwJueIGI1P52qS
	 V1N+NYKxujGtUczOPtVpnCqcZuv3a5sfKBWgNM1+JvHAMh30nZPf0KFcAuVb3R2imrVnK
	 YImVJsAJ0KRQ3X9IrbtvvruJR+L5y6evjSGCiUJQb2qLlRbuIQwJeoFDDPFoG6oovUg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794646499;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=dgd7h/eGUKH0fS43uNuchF05GoVnT34ahINAaJefn5E=;
	b=Ut6YMhJeNwaH/QMd+bruxFWb3+zZY1gVsmZkRmhESNR/2SoD2iX/+ePS00nLq5f62NmV
	 2rWjez2T9qeAOumJD4WHDj1hbxpOrsT5kvzSTOLng2mPjYhLmf/Uf/Ar/5ktaUB4rNI10
	 /cj13Q+GwAVT6OalvDPeX3x1kbI1BJEkzeOwv5eGqI2Z8aKQ0KfryYZE3O6hrqPdqHhHn
	 PN7XoLtIS8X6cEFTmysS8untoiQ2MCgdsIUSiuGrSl1RnvYxqDUtdTZSvC6a+nNM2VdaN
	 zujzu386S1huFJd7drSffaIMrdWOvwHRvc2Q6f7rNSXErj+f5Bv6qlTkSb+L9flhc1g==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794646499;
	bh=dgd7h/eGUKH0fS43uNuchF05GoVnT34ahINAaJefn5E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=0+qQH/0uCPP2OUHXHJLXAkPgnrCC8ly4erYaqFQ7IphipTF60O0kzMs4zIEgLr8nL
	 H2+BkCdh0S8Rq4cXcCKFiT9+MQ/iYWa6gfHlaLQcYyNG4lJOruBQFgFB2WlqPZDMPO
	 IfQ9rVRUafLnL0QEwbbVP4aXIiHi0888kfdGgjuGn6t49OoBfZsqUQWB+Fzpmvyo0U
	 SsYsRupdOu35SDyP3LzqlUVWDBzqNEgMWr9VfwSuYaDDKgR0s/smS0z5c60TN/dTLW
	 3Bg7CTGUx8Y91pVxHqtIcY9WMaQoHTpdP4b4ug3DZ6F4+TkOlNudSL29uRMi+kPc9C
	 ysET+u6WSf7Gw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 08179816D8;
	Sat, 14 Nov 2026 08:54:59 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9C23C1E7
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 08:54:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 90CFA40DC6
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 08:54:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lHTcngjH6m0H for <u-boot@lists.u-boot-project.org>;
 Sat, 14 Nov 2026 08:54:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 588E140DB4
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::52a"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::52a; helo=mail-ed1-x52a.google.com;
 envelope-from=csharper2005@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256
 header.s=20260707 header.b=dHCnxrEp
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com
 [IPv6:2a00:1450:4864:20::52a])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 588E140DB4
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 08:54:55 +0000 (UTC)
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-6b734a19fc7so353041a12.0
 for <u-boot@lists.u-boot-project.org>; Sat, 14 Nov 2026 00:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794646494; x=1795251294;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=dgd7h/eGUKH0fS43uNuchF05GoVnT34ahINAaJefn5E=;
 b=dHCnxrEpRfraC2/bMNLW6Ve7TCaoNV6aKQ9znUWi+F8ic/odc6+fW5tvDN1cLfBnab
 i/+6fUbARMXBfh6cmX/0MUaWaPo9Y54x2qC/DVC7cIJG2NCmLmfY2+IA/lCaztjveZn6
 imNidqFre1u4wTW4Vup1gzDCSPF+bWeoV6PuOfAbpNVxY56q30L2c5mgoi+4KE1reZ7r
 8tCiSDYaepWToumzzLri+wnBFKBgNL0f9YYJmhuGnnDoW3ND0MNG1yGUbeBMCo3JoP3/
 vGA2wLvCvVVOZx6QelcFe51F5SSI21hPHq5QmDtz1YXw/AZChOcAG1PPitGqTez8sYtg
 ih1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794646494; x=1795251294;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dgd7h/eGUKH0fS43uNuchF05GoVnT34ahINAaJefn5E=;
 b=dyg2i5Fh0i1SMq0EaSSzt4RD/GCNsQJj3op6NMTf61+hd1b28OBYrUCCQpHpYytZx3
 pW780nUoKeurUJnO65vW4wyxrOvGijWoLKxLYsccKIUSpxdIxyohhTUJcmAmdm6lvI52
 pCfU7gOkq04a0XyVoHIWe1kqR/df5HMn0kDxMuNULpsjxPFtnou6th5A3Y/F+p2KLU+9
 Ch9VeFeGz5hYXbrismjWhSVR91b+BsfU5XNK7Ps2K1iQu5vIsoI9Zq4tZIBOmiPmOcAJ
 MHk4UJCxsr9BZPWwmkbeYxNyYoAbRyOEIiHqJz/CktaroOucosCWKx1e+V9feuMMCUn9
 DRiw==
X-Forwarded-Encrypted: i=1;
 AL+hErGXAQGGjdcKlwpvZEvbGrKBG14dig3Be+to7IscwyOLMjmkuLxDFkRut5aGrYfeAdm0Ma3NyG0=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z9HV/IJfZp0mrTSX8H+3GdxfGVrvqiAB556YG5dbeO9FAxAY4bF
 LqRwVuVoC3jEPjRHvfoZHt8+fz+WIFD6abB0q3zUeI2cL66t+Qi90ugt
X-Gm-Gg: AYBFou3Om60Nag8GTEfApgQ+k+CJlPyu6Co2SPRmNExCtA99rNz4xGjqxcgMJRqx93q
 4GPNUEM8FOJ/0Y2C68NEY1Vo9XhzJIF5/lGHCfwKGsHHxpbO72A9DxW0QUygEk5YaRcwqAT+XE0
 a9VFzQPsrhoIJnB1VW8rs8o0e8HKVSDbCaTIeSh1Mr5Y2cce5eLNlp1itEpB56BMUZEENbxHrA3
 CKwF+8SKZO0uxZaRw8VbHDsPCdjMnpVF9J9v/0wVDlRmESfIAdO1cCmjmwB/FNezfsORNerLbUX
 j3hvnQHli+OOFKDcaqISu4WpPQyY1Ss70Nj+MjK7wRN3K4qVtWTJNYxFqyzF35bEPH/ImVffBSv
 npTpT0anBdZcs6sHGxqNpSKuHwT2JwN6/OyQ7RDX8sAJiIoN4U+kvLOqJYdTDoaxDrjmroMUoWQ
 jE4bj3R11p/Qk1ZAbGBMSzVzrgrWXlB99RNxMsog6YWcCfIF0fbzxulZ7n6mD2FcER0rFH7Bn48
 G3q4aUymnctIk7IiXYnuEVgo9U0sKYfOwpXjwaBgHjXR6NPU2KiUZWXG9MYgdb0U5yRUmGGjVLA
 Qn3wD46Se+wCwNEHF+PNpkrnCoX4Zi75psA5Fe/Z5ws2eoZieQqf/Jlrjl3Ix9i8BoFmtgIZcMw
 =
X-Received: by 2002:a17:906:a0c7:b0:c50:6fb5:cbdf with SMTP id
 a640c23a62f3a-c509633b311mr408752866b.2.1794646493700; 
 Sat, 14 Nov 2026 00:54:53 -0800 (PST)
Received: from ?IPV6:2001:470:b51d:1201:56bd:184:ef6d:ccaf?
 ([2a00:7c80:0:3a2::14]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c5095b6f6eesm191303766b.63.2026.11.14.00.54.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Nov 2026 00:54:53 -0800 (PST)
Message-ID: <16e53f82-a98a-45cd-b3f3-b300f9c380f6@gmail.com>
Date: Sat, 14 Nov 2026 11:54:51 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/3] net: mtk_eth: an8855: fix packet loss and sync
 with Linux
To: David Lechner <dlechner@baylibre.com>, u-boot@lists.u-boot-project.org
Cc: jerome.forissier@arm.com, ryder.lee@mediatek.com,
 weijie.gao@mediatek.com, chunfeng.yun@mediatek.com,
 igor.belwon@mentallysanemainliners.org, jstephan@baylibre.com,
 GSS_MTK_Uboot_upstream@mediatek.com, trini@konsulko.com
References: <20261107142441.2104669-1-csharper2005@gmail.com>
 <1669b6d2-2179-4187-be4f-f888a93fc040@baylibre.com>
Content-Language: en-US
From: Mikhail Zhilkin <csharper2005@gmail.com>
In-Reply-To: <1669b6d2-2179-4187-be4f-f888a93fc040@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi David,

Thanks for taking the time to review the series.

On 11/10/26 00:23, David Lechner wrote:
> I don't see this in linux-next, so I'm guessing you mean the proposed driver
> (not accepted yet) [1]? We should state that clearly.
> 
> [1]: https://lore.kernel.org/all/20261009161102.38961-11-ansuelsmth@gmail.com/

Yes, that is exactly the one. I will update the cover letter and commit
messages in v2 to explicitly state it is based on the proposed Linux
driver, and I will include the lore link for clarity.

> These sounds like real fixes, so each patch should have a Fixes tag.
> 
> Fixes: cedafee9ff39 ("net: mediatek: add support for Airoha AN8855 ethernet switch")
Agreed. I will make sure to add this Fixes tag to all three patches in v2.

Thanks!
Mikhail
