Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1319CC5DF94
	for <u-boot@archiver.kernel.org>; Mon, 24 Aug 2026 14:48:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4601880B5C;
	Mon, 24 Aug 2026 14:48:44 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id fRy6r-lYkrzW; Mon, 24 Aug 2026 14:48:43 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787582923;
	bh=VSapvP65X7ZcwKYbTL+3APmSLeE6uJ5REPP1oMvZwgk=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=g5s0fsBb0mYXeLMXFLkXLE8buh0W738jlEbHUVcRHb3vtAC4rIpZzvSQLcgSn19Zv
	 SoAH8dh3etnmHIx8UD6FS4KEPJD4GZpZ2gUMgBpkOG+bfduSzbxjxPVO8zjd1rs7oZ
	 mgus2sVBTzY5JMsi2dmJa7F3p6N5ck++KQ8/l6zbKTxECxe+yKrlVhoKZ/s4TLl2aA
	 +d6fQJuqS3VNOfA0+4z6Zae69lIrPUnDkq/icraeTOnRZr1bzHWV4F8MP7d7larQ1H
	 1nSNZkhRLxL4Qq3k2EqWxS5V/ykwOW82Q8QbvThEvfz1RLAB2x8VDYKdtgHh+ExMvN
	 k4S2bXmtlyqfw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8251180B42;
	Mon, 24 Aug 2026 14:48:43 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 2A59742B
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 14:48:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1D2DB80B40
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 14:48:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UI7dxPLY9PRR for <u-boot@lists.u-boot-project.org>;
 Mon, 24 Aug 2026 14:48:41 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=mfY7CXKb
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp1.osuosl.org (Postfix) with ESMTPS id E54E180B42
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 14:48:39 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c197e7e4e94so636667166b.2
 for <u-boot@lists.u-boot-project.org>; Mon, 24 Aug 2026 07:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1787582917; x=1788187717;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=VSapvP65X7ZcwKYbTL+3APmSLeE6uJ5REPP1oMvZwgk=;
 b=mfY7CXKbCY11jXBHHWnSRroSBJF4CdQg4K3ibuOHSjsch0r1GkeESJQ+Leu0Fx61Xe
 gYQ+oR9RxTVMNV9X9T1qq7S7vfI8BiNL+Z2sIvtDVdQUKCkH2FP1GE3MzGdJUu06++ln
 MZNCTfyWfTXveypjMGmrp08iZTMdz3YLv4Kmn6bhChu5GNNsYZa+nW+IAqkn9802IW6M
 HqD0e0b872RDDF3zZgqkrxEzvn1jrrdyTY0hhom0ciImj9yjWyvUiOfas3Dmhf/luKO/
 7WZ7bAlytF4mZYAVBVq250y9RT7xXL5bDY1G1xSmUoLVgIBmaliJml5dkNNuRmSLLyyP
 8PIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787582917; x=1788187717;
 h=in-reply-to:references:from:to:cc:subject:message-id:date
 :content-type:content-transfer-encoding:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VSapvP65X7ZcwKYbTL+3APmSLeE6uJ5REPP1oMvZwgk=;
 b=ccGFrOdDLw6a0xIA3pd6+U+uouYno1O3ymom629ytLNyWMmjIpZE0/THe25JBhm8u/
 ULdRG9zMcXdOycSjAXCLunxx8wSQputWqVk6aYD/frksyzE+it/hTXUw0ozrLQ6hAElM
 qxNcMJS8m+KsUcdM0x/zxQ7k8fQ3KcfapEFlVOx1cEoEq9gyh0wP25ByctrQQgrV3LAG
 jxPtO9eai+WFWIx9oYGDnmx7KrWi/yTloxvc1j95VjdrRyTnQVoKI2SKHNXBo7OxyzlM
 04rGfKHmYEQL4Mf02RTDCuZ1UdTtD57qWVbWIkSoZFq5QVqAErwvgR9vGGE5KhvpPwJJ
 NKzg==
X-Gm-Message-State: AFuF++kl0jkd/03N2opJNc21QdTYE5HlhktoV8Aayj9BA5YuPRxBMGDk
 14bkrylWPAa4dICbBRvh1uxXnPOXfgU35izfooUAxeuA/tsSgqR8mSSgY/P7x0yyVrgrZrOYTpt
 QlWGuhZo=
X-Gm-Gg: AR+sD11bkazhAotf3TImZIoyMugHCN/m/AK8DUc6uVQUyQjga7XpGMUqb9xTM/+VQkx
 veKddr6wSDGzx3bXjC8JGX1dhi2K0tuaLItI01+JgnmRGsD166+RLWMqyl670gUvg+Hdzs6Q0ie
 tQ9I6Dev5L0kXZMJ52Jbf8bcSjuLpeQiRAkmQl/TNTmH+UBh6tUZXjhW1S8NiGbXJ0Sin/kYu5s
 qB0FJ3I1HSubWXRi6vtN7kOZEleUrn7AXcUjuKRob+Vfn6ZMzF4FWHN0Nnv7kcJ/esFFJv0xgty
 Y2nUGIm8kRQTQxViOcJQzQmsp732LqX0e36/WdcL2bbLkHb+aKe/9GA8WgB5Ntm0MUNyceFbdQi
 rURb6VDMxp4+JY8BRlrnHBxuHG3e9UviQoCCKV2Q3dhQ+lp1RsZ6rB/2FezJKG5cZkNINoOA50X
 5DlVrhRrTSnFBxrzSIlctW2DRqqdE0MAsoMcuTxpYVtavDXQu/hZdnxCnCvmdboxQ4uX1Lx0qrU
 uDAQ4PWumt2k3QWG72LCs9EWgoRhJ8hRLAv8lXGh+SgBHstCnu7ZS90
X-Received: by 2002:a17:906:730e:b0:c24:7cb5:d617 with SMTP id
 a640c23a62f3a-c249238c369mr2094959866b.1.1787582917473; 
 Mon, 24 Aug 2026 07:48:37 -0700 (PDT)
Received: from localhost (host-212-171-227-71.pool212171.interbusiness.it.
 [212.171.227.71]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2496734bfcsm1409134666b.43.2026.08.24.07.48.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Aug 2026 07:48:36 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 24 Aug 2026 16:48:36 +0200
Message-Id: <DKX99AW58JTS.8UMKA33XJC4J@baylibre.com>
Subject: Re: [v2,0/5] firmware-owned devicetree for EBBR / SystemReady IR
Cc: <u-boot@lists.u-boot-project.org>
To: "Simon Glass" <sjg@chromium.org>, <ccaione@baylibre.com>
From: "Carlo Caione" <ccaione@baylibre.com>
X-Mailer: aerc 0.22.0
References: <20260728-ccaione-upstream-ebbr-v2-0-4efb529140d6@baylibre.com>
 <CAFLszTgX08U3GpcvwkvzBinY7X21EC_P2nEZPx3ikVH=vBt_yA@mail.gmail.com>
In-Reply-To: <CAFLszTgX08U3GpcvwkvzBinY7X21EC_P2nEZPx3ikVH=vBt_yA@mail.gmail.com>
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

On Sat Aug 15, 2026 at 8:45 PM CEST, Simon Glass wrote:
> Hi Carlo,
>
> On 2026-07-28T13:20:42, Carlo Caione <ccaione@baylibre.com> wrote:
>
>> Patch 1 makes an FDT passed to efi_bootmgr_run() outrank a Boot#### FDT,
>> as an independent behaviour fix. Patch 2 adds the loader, binding,
>> documentation and shared EFI staging policy. Patches 3 and 4 integrate
>> the EFI bootmeth and boot manager. Patch 5 adds sandbox coverage.
> [..]
>
>> - 'fw_fdt_part' can pin an A/B partition and 'fw_fdt_config' can select
>>   an explicit configuration.
>
> Just to check - is exposing these as environment variables really the
> right long-term interface? U-Boot has been moving configuration into
> the control devicetree, and both of these look like properties that
> would sit naturally on the u-boot,firmware-fdt-block node, with the
> env var overriding for A/B slot selection only. What do you think?

Hi Simon,
Replying only to this point because all the other comments have my ACK.

Agreed regarding fw_fdt_part: it is indeed intended as the runtime A/B
slot override, while the stable storage location remains described by
the provider phandle and partition UUID/name in the control devicetree.

Now, fw_fdt_config is slightly different though. We need configuration
selection to depend on the selected boot target. For example in our
usecase, the same firmware FIT may provide a base-only configuration
for a generic distribution and an overlay configuration for a platform
image. The control devicetree is identical in both cases, so a fixed
property there cannot express that choice.

Static selection is already covered by compatible best-match and
the FIT default. I would retain fw_fdt_config only as an explicit
runtime override above those mechanisms and clarify that role in the
documentation if that is ok with you.

Cheers,

--
Carlo Caione
