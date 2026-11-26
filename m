Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B528606A31C
	for <u-boot@archiver.kernel.org>; Thu, 26 Nov 2026 14:22:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=P4Q72Llg;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=YMe8AsZ/
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5037E60AD5;
	Thu, 26 Nov 2026 14:22:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wb0PJ-Ki0-sX; Thu, 26 Nov 2026 14:22:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5F1EE60AC7
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795702931;
	b=oA1pyDwPCKCh5aldi8nrdiBkkEbtdMfMNI/s9HTfZS3ansSLJ45shSUWx5SiaugFrER3
	 v5J1JPmTzmkvms6DR5nQGBJkhVvkMRJtR7zzInOBFFQJUUF81UqvwPFxYd2aV8wk2+MdL
	 epjKJdmfKd4Bsv67DD/Hf5XUrWQ+g1k4Imupal38rhy2Jqvu91ZMvVOztY9uG3/iOwEav
	 KBq00MqaBJ32MglP4eEVKjXpzwX1boIaoXtwjLA9WHgDvSGoeX2pX2x+L7iC9yZISml+y
	 DtFWkmT7zoRcqpc6IltqPXgNG5/NQrPKvTE6EsN7BfmQrqQyTnZ1+YWPN3V2C3pJTxg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795702931;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Subject:From:To:Cc:In-Reply-To:References:
	 Date:Message-Id:X-Mailer:X-Developer-Signature:X-Developer-Key:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=UayqdipVEGWxIQzBktjUrYGhVG0zesJNITLN83t5I+4=;
	b=X0UgVWUoKVighSQgpMFu4DfDQSfa7uGnDFunCUUUrXgwxwsu1vAmLhKQAnZS4qTrQzrU
	 I3fxNigOTBubq+gSh/oxEuzZpuuSi95Qcob6cjCbP4B5avG8jwTC7StRa4mbpMJbnp50C
	 F0jzWUiAvA/ChA4InaHhpxM3l1emGRIuKcdNsoda2XgJWSOdJFYyuLd3KdCFpACYEJt7e
	 hMjAti5aLGftKKFJOVTG9ACWQ/2+YpaJTm2JaV+ItS0eDolvXVsdN3Uaq2pm6PFq38yJr
	 enOiagbzs6pBtowA47vks13kY8CN5/T/RBo5zjxmyp/Ou46wAdcjG2OYCSYG5J5rXlQ==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795702931;
	bh=UayqdipVEGWxIQzBktjUrYGhVG0zesJNITLN83t5I+4=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=P4Q72Llg5f2Ssw2hTInzgQaJUGV5pIz35P6nC7OCWaq53Pk4r3FG+vCckjmtz3NQK
	 hFg38dRPCibh8/tLHf4qypJa2cVX/BZfoKI9HHIiQruMN/pV7KXvXFaFL9Md15RRqZ
	 5L7umaR7dFt/V7JyOEZI2JUhQsMxDJNLSl+tTltRUJsnT9nwc3KcGNwlzZM9x/S0Dh
	 0hgW68gGEE1oPD23MOsuGhZsf+03vdNPqmB2d/Pq0pRxLr2jvyD/sDCAzmqNNt8pya
	 nbiAS6Tl0xiWhwW24IqeKIDnRTwcN5y0+UHLpginIOTTNUM6D+/5FnTLBH99ha0vN5
	 w4aTacl9ey3Hw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5F1EE60AC7;
	Thu, 26 Nov 2026 14:22:11 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id B429210B
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:22:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9ABD1404A4
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:22:01 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id GeSfSv7ByvTV for <u-boot@lists.u-boot-project.org>;
 Thu, 26 Nov 2026 14:22:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org C2B7140111
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::334"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::334; helo=mail-wm1-x334.google.com;
 envelope-from=glaroque@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=YMe8AsZ/
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com
 [IPv6:2a00:1450:4864:20::334])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C2B7140111
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 14:21:58 +0000 (UTC)
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4bb70074ab2so75587755e9.0
 for <u-boot@lists.u-boot-project.org>; Thu, 26 Nov 2026 06:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1795702917; x=1796307717;
 darn=lists.u-boot-project.org; 
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=UayqdipVEGWxIQzBktjUrYGhVG0zesJNITLN83t5I+4=;
 b=YMe8AsZ/4n/koxUQRh5M53orLbhNBxOf70SsNUQR0oU/iFwrUc3vuRB+3EFJ+b57mD
 gFyd53HtezbdxLgxCmxIqXD+HC1Pf6G9rfR4yXzwYSpRSxKhGUDBHWx0q7Zyjv/CBYCd
 ZXNFJcF8lyTooQLWqro8sy1mImOIcxgs26DQR5VMft7jZfwF8gLk+QH6SidZCd4V0CoY
 hS8wQj8gKDhYeboEdNGrH/BUQ32Flo+d78a2fWRG80eGNOd+9AYbvCw0MCGMm6m1lm+Q
 HmJHhWA3Fhj9ONUqBH3L0nsjjedD5rnsmgyTdPAyeQPl0IiIVolW+ocFVKQ0mmrVgwyk
 50ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795702917; x=1796307717;
 h=message-id:date:references:in-reply-to:cc:to:from:subject
 :content-transfer-encoding:content-type:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UayqdipVEGWxIQzBktjUrYGhVG0zesJNITLN83t5I+4=;
 b=14u2jAyAtHS2SFcqumnWpaHUSU8CARwQF/NPLn3FJ60s4Gn0CO8TDA3OIXzV9/fq0U
 xd9xpHCLYxLg4U+WVXczAbKjPOcPsj7DrXCWzGbWGCg2pcCLbSum+q46yCLvEXrcH2sb
 fWMud6nC99SwRX4KQR69rx20Z/SRQdOUCJnlEg20kRq3V05Xun75rC1yAu7D3Wq8FPx4
 2+gWJU2o95TMKLXZ7ANv5INdaoqLRgfHZEZh7Jm55IYVy/ht/yM2MdoJ/A+4BoSnp1zz
 JTg9ktyTvFIREwQVdUKchx9Nwd7eIPoZievWveYpfMjC1p8flFOW9bwN+N53ciJ+UyIg
 Z9oA==
X-Gm-Message-State: APuU4Z85feVuTEx7uYOjlm0C+lKTTbWtOp4nbMwNwBQM5UVn3TxzZEjd
 oG4MPBjICCzGXOmC1dgRy59+Lmt2egf9sp0W0XdBvjK6igD6Xfg0N5xHNn1TSwUP9Xc=
X-Gm-Gg: AZFdTZdI40hP37w+qNcxY6AT8nPnMdyvEX/hazRwuk25/GlqWl7axIHFgdJE6Qzm5J9
 BeLDvv4RkNfrfvvxBlQSiQqafZ/qnyfvQHjG/8hIoWHWBMhhiQO5fH/Nnx+JVKTSM22aWQzaxT9
 nuMaLobm+j/2KZut2M7QXIOkJJDWxramjTT+KG1IS4cECmykBkdRiWBS8R7DHnPbZq2VnO1L7an
 TsPZQYSrTuc205DcqVh8bvVzjUjRu+N1uPPoZHsObuFW3ldKckE6oS0OFr45l6kjn/sIeWfUNeh
 ld8SaqBSVuYtbDHhqGeKKW9TLQhIeE1yHWWZGXIR9UCflh+Xel4DqgDxgdmW7R5Xi18dJAL4tJn
 WR5S2eYg9ULw34hhUWqOUI0f66lnj0Xm3KoiDVD0zsp/ue0GsrfAgMHsJYw6Zb+myJXz2OT3mNn
 u5P/lONqjs61rEEZZ1aKtU1cAzb0j0W5EUYgwtAsTwRe85DRQmqPC5lw2ARjF6sr95dss3PjnJy
 WW3a/9m99EE9woYKbQZXyWS6C04hRSmI+7bFZb4xqsj/lfHjylYGwkZlolGCooox5McKjp8nEHh
 qpICPxho/HHqwaDxSz/p7l4myAOgX5P+caOw+crxdBn1jcDvDS4=
X-Received: by 2002:a05:600c:1d86:b0:4bb:6a5a:7824 with SMTP id
 5b1f17b1804b1-4bb8892099amr455731425e9.30.1795702916702; 
 Thu, 26 Nov 2026 06:21:56 -0800 (PST)
Received: from [127.0.1.1] ([2a01:e0a:e50:3860::e1d1:d182])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb90655f5asm387647325e9.1.2026.11.26.06.21.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 26 Nov 2026 06:21:55 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH 3/5] riscv: dts: spacemit: k3: spl: Enable various devices
From: Guillaume La Roque <glaroque@baylibre.com>
To: Yixun Lan <dlan@kernel.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>, 
 Yao Zi <me@ziyao.cc>, Junhui Liu <junhui.liu@pigmoral.tech>, 
 Tim Ouyang <tim609@andestech.com>, Leo Liang <leo.liang@sifive.com>, 
 E Shattow <e@freeshell.de>, Guillaume La Roque <glaroque@baylibre.com>
In-Reply-To: <20261122-06-spacemit-k3-spl-nor-v1-3-33beb921011d@kernel.org>
References: <20261122-06-spacemit-k3-spl-nor-v1-0-33beb921011d@kernel.org>
 <20261122-06-spacemit-k3-spl-nor-v1-3-33beb921011d@kernel.org>
Date: Thu, 26 Nov 2026 15:21:50 +0100
Message-Id: <179570291086.2502540.1823196271757055655.b4-review@b4>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795702912; l=723;
 i=glaroque@baylibre.com; s=20261019; h=from:subject:message-id;
 bh=GEi/KxgmUIU0yeYPlyTSv6YGa/f2rtmid7nqb+hFnwM=;
 b=2sW45+5mixdejoVy17zkX0f6/pRud3eAHTsq1d8s7bNO/elhNPZqbL+F6YgRZr3EJR1/ihYSf
 Huejeu4BQy1AORuuK0rc00TqQ/0XHXsLx+sKr/1G15YuRwmwbkQnIEg
X-Developer-Key: i=glaroque@baylibre.com; a=ed25519;
 pk=nMpSg4NT6M6q143E089emouMc+MXpHO9CWmnEUfjhjI=
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Sun, 22 Nov 2026 02:34:11 +0000, Yixun Lan <dlan@kernel.org> wrote:

Hi Yixun,

>
> diff --git a/arch/riscv/dts/spacemit-k3-u-boot.dtsi b/arch/riscv/dts/spacemit-k3-u-boot.dtsi
> index 13ab6cba3722..c41c117811c7 100644
> --- a/arch/riscv/dts/spacemit-k3-u-boot.dtsi
> +++ b/arch/riscv/dts/spacemit-k3-u-boot.dtsi
> @@ -35,6 +43,10 @@
>  	bootph-pre-ram;
>  };
>  
> +&pinctrl {

Nit, the nodes in this file are sorted by label, but &pinctrl lands
after &pll and &qspi / &qspi_cfg are appended at the end. They should
go before &pll and before &syscon_apbc respectively.

Thanks,
Guillaume

Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>

-- 
Guillaume La Roque <glaroque@baylibre.com>
