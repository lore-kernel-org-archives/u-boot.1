Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 767EECA5FDD
	for <u-boot@archiver.kernel.org>; Sat,  3 Oct 2026 05:40:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4D7AB40693;
	Sat,  3 Oct 2026 05:40:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mH8CVoMAV-Vl; Sat,  3 Oct 2026 05:40:34 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 37E0B4068D
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791006034;
	b=cINY16MBYI7OTOMlvJFgkCeVEkdFxTR3cA3rZMlwyioFBvwo8jT9v7wFxgZcQNs/SzH0
	 4kmnMJ3Lw0S29bS+DmC18Dw//6UhqcX7LJr9XD5ei7QZdQ/0NnxUM/WpNHiDY4JY6+O5T
	 bjSFHn1QFR/SQBRhUvn1X3mWxTTJqmiEP2nr07X0g4kqSQLRsfKBdo78xmI5aMftvg+4x
	 /xxdl2bAna+lp/6Ps339QJLS3WKVkMdxbWzmy4g28Kpd4me3Zwxm637O79VhNzXAlihFo
	 iHMkQKEpxdvKOJZ+9ZJOs4+neQRPalTfBFE7nAfS/xGC0s/rUJF1fZ3leL0dja4Z8Og==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1791006034;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=HQ7n6zUBHrl+LuC/9mSKagkXM7rM3YA5b78oJhJp1WE=;
	b=sQURh5YfUCdAAHPKpJObVYhoP+GujbMvsf6FpxFJQTxiYmutIof1pNA/tyb3FRFW31J3
	 yeIIKnR4t/t+VolTzy0yiPUH+HiFfAPsMBdGwsCJZp6Rq7upU4pSX3B47wQ/aoSeqoqFx
	 yi2TXeEuGw/ex3NqbBoFkfy1ngAvu2iQVY0pms2yTNteQ33+WyN4wAxJqQZnnm+nXRnWw
	 XSK2IsnlGRiY1G1Vz3vvW3ySWkBg2UXRoHU5nr4x3MkqDF2v7BIVTW81PwI+g2iO9B5Fh
	 bxNWS9Oe9ijbEJwKikmMNxzvl+poq1qo8vXSPDs/yakcr8gHsB9IZoc4s3C8AbPSW4Q==
ARC-Authentication-Results: i=3; smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1791006034;
	bh=HQ7n6zUBHrl+LuC/9mSKagkXM7rM3YA5b78oJhJp1WE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vw/rrOS6o0B6txQXBgpSa8omwGXxCgOqhONFhSt7oP7G9BNv7S4Hgc58sV0rWdZ4d
	 KyKcQquOOlF6wazHy+voW1NpEt6Uo6HcRcmW12S1RRgtEDm4PrWrk85D4BagUdTLkm
	 VQ3+0KDD3T9vCvPxbwdL4CCeq/zuv754I3p/P/ufgNkT4qIZK5wjqfsM4m/2186+U+
	 8u1T6twz0YypIvaI+Bo/oX9MoHmI4vjguL2ts3ZiMoTJBNj+toiaST5ypWppkJeZ/A
	 bvKcKdO13DosLigx0+yesMHvG2zyA4olGA7hN4A3LN4sWEVZApMnp/coaqmXBivI1k
	 LtJrwl2T9LqEQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 37E0B4068D;
	Sat,  3 Oct 2026 05:40:34 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 389FB1D2
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 05:40:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1E4A160624
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 05:40:32 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id o9qcSPrUTYYO for <u-boot@lists.u-boot-project.org>;
 Sat,  3 Oct 2026 05:40:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 20F736060D
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:34::10"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1791006029;
 b=K73aaR5Ip9ZuRn2nnbPglKjZnrzjYLarRIDvC+4vGQHgvHXIQFLUHrH5ubmJpfJ/nXGT
 ZjAfbF1UtLsEKye7fLm51GRxl62KeKWASgF/7onN3aKg6Rgb/twhCTaGAmwdgeTB9/2g/
 t7upNiaDSMxq9NVDVzHK4RpfHrGYZSQPO3WlGj5tK9BIc4LUvAWFV8XsR51b95YhsBVad
 7J2DC1bZLhls6Ze74d4gofgCJfqsrUZq0WmAc/5autiLKbMkqXEgt/PaWmYU2E+VQz83k
 CmoLQLT3IbN2FN7c0dOuOnrUFnV9+4bfGIV0WKo7w423E9EpAMU0Np14JJ2iayi4Lkg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1791006029;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=HQ7n6zUBHrl+LuC/9mSKagkXM7rM3YA5b78oJhJp1WE=;
 b=gCPjUh3UREWupPNRlhhvWDVCgTT/0JVoQrk3GspFDYO9YIBBHaJGt1RJUFrywgeuZ1aa
 CbebZoEkJrMa/52DxBd6eY1Pu6OnV4kg+Ru8JXrYeYyt7YqDv0EptpE1XLFwfz18qUWVE
 7rgwnhnay2g4MN+gtA/qGDGWKl0qN3sJ0WDx9bA8dDxSlwW3UMHfZGumXVeiaEj4ehrVL
 iL8O8hqaVaV+pp851MdXYRVQgtMzPzruXmV5axRtyGb10Uiniix48h5tn2yblzikrd0DR
 Enc7dQi+bdwqSmcpNtaCP2bRDXWLcm3NUy2XPlFo+01Pc5jXQfB2/tXTUjF7WjEzShw==
ARC-Authentication-Results: i=2; smtp3.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=Nlr2ffMe; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:34::10"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:34::10; helo=mail-ej2-x10.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=Nlr2ffMe
Received: from mail-ej2-x10.google.com (mail-ej2-x10.google.com
 [IPv6:2a00:1450:4864:34::10])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 20F736060D
 for <u-boot@lists.u-boot-project.org>; Sat,  3 Oct 2026 05:40:28 +0000 (UTC)
Received: by mail-ej2-x10.google.com with SMTP id
 a640c23a62f3a-c29703cb470so82836166b.0
 for <u-boot@lists.u-boot-project.org>; Fri, 02 Oct 2026 22:40:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791006026; cv=none;
 d=google.com; s=arc-20260327;
 b=sHd8idKqdmbpE5o7nOLivKlIgfDzv/bfm079JgZqLTdlPm7SOaYMJye1szlSti4OBv
 Q4SB+0HB7E5AG3I4FS6ajV6h77CHyZOAsXulEvnR0m2hBfusR88Rjst9mQvUaBuk37xn
 c/QQEE68dUwrbpkuFy5tI8Jfhv3VZA1jS9ZlxTfomJRqwOAoMVf550bZLLysNVd/iSI0
 JuAZZhNkNjAphvrdLxBCINaJhfoE+Tf3bYWpZOUyDmBOXJQpQ4HzntVe+V+jPaoL/Xqw
 El+kiQRlUqD7RTMZ1M5GAhS1ke4EovTTiwS7BIRpN5nFaGlRO4SHSq9P37BQGm12cwqa
 IBXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=HQ7n6zUBHrl+LuC/9mSKagkXM7rM3YA5b78oJhJp1WE=;
 fh=0qe9457v60VLqx60NqTtePLmLFms9CoDKTfMC2tBpVc=;
 b=YSv5j3GnT3JMF686d1KSser5dDMp70NONrBLIZNr0R89LPzYlcCnxTNjy6hoqujY5S
 vxf0erPxRI7iaDVqk1gy/FGR2u+qCPMAidsYZJP8RXZ4n+BDaIP1SIEE4VAoWi0c/h5L
 daDopC4KIEagRaAvataice+1Rmvox79OF9ZYWsfZeeR8KoBdSZ49nGbaaBKTRyVDaSC+
 ErZrncXctVrcG+WlP6Mwtfod84CwCKfh5lxTDz3eiVpUTNMCgcSpdrcfpiy911fPPH9u
 Nwe9eekeAG4HCBOMSs64pDVTkBI6k7p9MfCFHo+HMy2hags2hb4kSz56OrhHQ67402yL
 gAhg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1791006026; x=1791610826;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=HQ7n6zUBHrl+LuC/9mSKagkXM7rM3YA5b78oJhJp1WE=;
 b=Nlr2ffMeaKUTN8k4TUE65Vonpe5jouCENpvsZbanqEtarGvIjYrFQdOfat7QpTEWaY
 elYt5Ef8D4xDH2gkCENK4qQ21Ezt7Y01tUE488PNEwlKdSoSGS/VeZl3/hZ9J6RumqLM
 Hk3tZ16cRntTTITMRAfq6Y1DWbu7X+L6CleCM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791006026; x=1791610826;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=HQ7n6zUBHrl+LuC/9mSKagkXM7rM3YA5b78oJhJp1WE=;
 b=nWpQIKsgFnEzP4TLDilbwjv8fPWXkU30Ps1Yg3E6osI+wGh1HuzvoUsViI/xstqOey
 MTSGQTPAiF9Q3MY15LgKdVSThZDL0EiMMSQCKAxnMK1nxdLZKJ86l9qhx0v6S+uuOeSX
 Gt97Sl2OCeXQutfwJKnjUkvi8XAGiKpCO46/gZVbYHaQg7SnO8AErcqzVoN6RcDvWJN6
 aJT0fqMAK6uytnxnv9ApgeL5h0HqcIDmoqWd23h1R4uzv3lKySItkEhMufYXsHAje1Co
 S/V/XKqiaIrfgk9J90ZwRt+z57E6EpjFhzuOmaoTnh54Mkh6Hy3MW1U2NxM530pj3l7A
 W1Tg==
X-Gm-Message-State: AFuF++lWuj3JjB+k9k0BGJKZSYzDQMaYUhrdwVk1zcsN+jodN4htgYXg
 IxOSew5dlnrggwyaAB99PdD0EMwWF/YbjYKhj0khcdsxBToXDwPwWoRwSCOUKi/o3oAw3+RSHa1
 c5CVSv1al+/sPMdv0XqqMxFg7vpmy+D3CxrHYBUfllIDEyG/nCeCmZQ==
X-Gm-Gg: AYBFou3xQt+arOsLHMylTK1sKzbk2+Q9Bz8L2d8UkIavKeIti+s5VLivEzmOz3Q5Z71
 XWKg65Pc7wrvhER6bn/PnG25v/NmN3O7gTpeky8GIt013Xez5ZyWf+2PzGhj5vz5bM+xJiBRROd
 gN1pmkUH0VC3NsFC9sxjuUpQ9fKmjNJ3qvxU9b255u+4vWDr48JAW4gIePhHvM/D6zbVAOLume1
 xOi+s1TEOhEDV24YgWlxRxn5+yX1BHrE0bllT0y4cDB95H2/JJd+O+JV2QkKn8mhuqWCSrilqxu
 RCffnA7e5G5MqFASVmPK0pDnYByEaJ+fXRICFQo6KzvaKwLGZXaPQoC3
X-Received: by 2002:a17:906:c106:b0:c2d:c800:d797 with SMTP id
 a640c23a62f3a-c2e4a90963emr368567066b.6.1791006026260; Fri, 02 Oct 2026
 22:40:26 -0700 (PDT)
MIME-Version: 1.0
References: <20261002073357.382228-1-aristo.chen@canonical.com>
 <20261002073357.382228-7-aristo.chen@canonical.com>
In-Reply-To: <20261002073357.382228-7-aristo.chen@canonical.com>
From: Simon Glass <sjg@chromium.org>
Date: Sat, 3 Oct 2026 06:40:13 +0100
X-Gm-Features: AclHuK8sFFZ1SEt3ZZsliO8A1ujAmBqcabmuK-JFIV-AS0CBq_YG0mhG0oTliOk
Message-ID: <CAFLszTg-8K_1Gm_NpF6nD+UsTMnV_-=BoNt8P-gPiCWcSgPMNg@mail.gmail.com>
Subject: Re: [PATCH v1 6/6] test: video: define WHITE and SCROLL_LINES once at
 file scope
To: aristo.chen@canonical.com
Cc: u-boot@lists.u-boot-project.org, trini@konsulko.com, 
 Simon Glass <sjg@chromium.org>, Shahriyar Jalayeri <shahriyar@byteray.co.uk>
Content-Type: text/plain; charset="UTF-8"
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

On 2026-10-02T07:31:50, Aristo Chen <aristo.chen@canonical.com> wrote:
> test: video: define WHITE and SCROLL_LINES once at file scope
>
> dm_test_video_text() and dm_test_video_text_12x22() each define WHITE
> and SCROLL_LINES inside the function body. Macros are not scoped to a
> function, so the second pair only redefines the first, and
> check_vidconsole_output() further down uses the SCROLL_LINES defined
> inside dm_test_video_text().
>
> Define both once at file scope, before their first user, and drop the
> two in-function pairs. No functional change.
>
> Signed-off-by: Aristo Chen <aristo.chen@canonical.com>
>
> test/dm/video.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
