Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 902C1C79F82
	for <u-boot@archiver.kernel.org>; Tue,  8 Sep 2026 10:05:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4145B606CA;
	Tue,  8 Sep 2026 10:05:57 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EiM2gba3lW44; Tue,  8 Sep 2026 10:05:56 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 364D56067E
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788861956;
	b=r2U8yUNntNFeu5Iel2IYIEf1FXWuuCkkh6PLXrhocImQpQ5bs53jOsLz37q28HMOHJRr
	 F46YFF7eOL2aciEaNhpK8fpgtILZZ/yDcNstm0HI9FyvbHkTICm2gKpD30Qb3+JmBV6d1
	 Wr5i52scIjC/kMfMRvLNS/B4zH5hgSEZ93LA9iCMS+PXYBe3npv/SbCgbOvy1TFhoRGqS
	 f+PtW0+cetsPqkei18G9oy1nvvtGRKpRx6H63nRgQnLLTm+EAFDV9dtXk1P30yHs41fB3
	 74Vl4PxspwH/5qxJ8BKYacjzWflbRWPEEFEcvE6jXKWaUTsfD5zUptQogJYHvA/D9og==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788861956;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=Fgj/z72TuUIlxXUKYWZwOoTT19oeTFawdiEXLe42ZMA=;
	b=YbJEjoHcg+jSnmq2Xftnunv29DyA+5TZ9dHCTX2p1asZbxkEeY7xtkHHpHM3z9GNylYb
	 lCl62afQtcNhghZ97GpUqtL2Ag4j1KRb2ljPcY03GcgPyYdiZZnU/1A3h3Frku8rUM4Jv
	 u9jOZYuAL+oyr+uAhyeB4VmqIB//QtkZFqVzeLlAfvZ9r0z4WCJ33BbvowZivRNk1pkuZ
	 O6XfHiQA72S6248RP4s8RgKUoqVOTeNZZDaisKtIeOGOFvEs9tJOQXHQ0qN5VBGs9UBsq
	 UaEw7xUxNkr3OSm4cuDfo54mTNxbdYtm46kunB94oTsmu9UIpAjS3YZiutITFPOHs5A==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788861956;
	bh=Fgj/z72TuUIlxXUKYWZwOoTT19oeTFawdiEXLe42ZMA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=FAOD+63JydofAfP74Th1pySzCPUqrjoGYdzns6FRsGnTf1Nztz4OXGcdwJDY2y72Z
	 7RofQSOxgngXOaa4dxvd61dcbWwlCspsy+PgIvLjQyy/dhsk3gQWLcgm8ChciS5Ip/
	 C57wdwLYqpIIT2J6EkVq1QgDqnKmAfZTV6naoRoM1fsuTnOe2ZgnqTg2oTJ8aseabk
	 ccZsekXeg7jtHtQ4H7O9LI1ROeLJSKskWhMuniwIqQ+WDfebDcMJEGzdDf7F0wwN4b
	 Rq+zeiKIlGzlmwmXO6TBKuIIW4HGxSsjIwhN6DxsaIqcltzeu+/+QV4NVlDewF0pkG
	 oTwT+c3wqaDgw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 364D56067E;
	Tue,  8 Sep 2026 10:05:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 8784CD90
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 10:05:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 79CC040063
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 10:05:54 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Xv0IUN11tM8i for <u-boot@lists.u-boot-project.org>;
 Tue,  8 Sep 2026 10:05:53 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org C0D3A4002B
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::62f"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788861953;
 b=PqLdOUJknIaFYxCh+kq7LuFhql9qdRFDwnNMHY8PnVsLouI5jFa6xqx4mcLsb7s2J33v
 5XuykcPzViYANHhorGcSdfaGXKn7ENZuL37jj6eA3A7lhC218ZMlkoED3ZLyQLZcXZL+F
 qmZpgIDabOfEua+2L4/YAG930pFiii2JXE2xv6K3d0Eyu3o5yZZHoWSbqFpeqSmGR/umT
 QifxN3ZWm4N0bq2pLH2VDLn3QlVWzQtpBOcWsjej8vAN27nYX1FSFSB4Ff57d1DCFAgz7
 /rQ9PLLV6uV6xkPLfEatObMSRBObJsa45wKQ2WLoos5b+7Bv3z0+OVoCytLwrkmTshw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788861953;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
 Subject:Message-ID:References:MIME-Version:Content-Type:
 Content-Disposition:In-Reply-To;
 bh=Fgj/z72TuUIlxXUKYWZwOoTT19oeTFawdiEXLe42ZMA=;
 b=pwmWf8HHYe8D15YJ/2/UoIajwEvfZ2SAzlKpzoAYCgekKgKRAEIVPQ26PUKhkARGdnaO
 5TXD86slXTAp7E5xhrKM22geeiAON/MQiFSCBSBz1VANnQ5m6jYCA6Jaju8HeNDsn9jZO
 VYCw23Ip1/znwHDboJDcGtiXOI6NSb3CeLrAv99VAobcmQUDDEtoYLehfq0MIVmxhmucP
 xENDdw1IQdONhfliP+gTxlZ3mxaci0xBsefgquify1eA7GMUv202HEU15NQNvu+kZRkQY
 cEs+fGucnkqVch4GtOdrYmFdGNjT3NvmVmLM3bw7eMHhrW8cCU28m7k1YPyjTnrG8ow==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=bu1p4pjX; 
 arc=none smtp.remote-ip="2a00:1450:4864:20::62f"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::62f; helo=mail-ej1-x62f.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=bu1p4pjX
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com
 [IPv6:2a00:1450:4864:20::62f])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C0D3A4002B
 for <u-boot@lists.u-boot-project.org>; Tue,  8 Sep 2026 10:05:52 +0000 (UTC)
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-c169ae1cb26so886803566b.1
 for <u-boot@lists.u-boot-project.org>; Tue, 08 Sep 2026 03:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1788861950; x=1789466750;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Fgj/z72TuUIlxXUKYWZwOoTT19oeTFawdiEXLe42ZMA=;
 b=bu1p4pjX8Lp4/qvnGdBbgfhQvniyhXdo4HwMCYpqPaHdnIWtcTEimefSLzEzot52mO
 AvQBl2g6fyt7Ru1mh/1pPAZ1jtyNrZtTkqShYfRMDbvS6u04SfplUwLRvvFFSdKMzsKm
 TkzbUF49Ox5M33b45UXpudyikCgNBJdpUf3jxPL/kc7icJUFbzkFSiYF6Rj3iLSLxxIL
 vAlYuZ45TpBGUFBEItH1YdQ4E6s5y3M3J0zC5ICaT/aPA/Hcd43cusGISt4E+BGnn6Mc
 mZTatjqMvJod7AcFm0e3odAEQhJao/7w3CZnkclxdjmgaJGn2PoYlknCYJkSQ/qH9E/0
 fwkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788861950; x=1789466750;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Fgj/z72TuUIlxXUKYWZwOoTT19oeTFawdiEXLe42ZMA=;
 b=SqvSkO6YpNQJ4GVym+q/AnFGhSy5zBy/S/Se+9yaESlWQes38Bi8UXknWxP9xYVTcJ
 1CNpZB4hjS2kYwc0C6/Tq2IiLRGNH2CTSAqr4ptGh++FPE+3okmoEXQ3C5h5yl6ZNTMX
 78PuKRb7+FoJERljh6T7KvZoj+lw4SoJ7rI/FgzMZGHcpCmokuAEtOGgKdCQZElzBDIq
 oFebjQmxer0rSca+btHiekwZo+i/OMpj3AE0rOWx8/txJ4kDHJ0AVg9vzxwJSgJjGtXL
 9dSPw1+AIyca+dbYsk6DK9ihkiqmGzm4FvZNcQS918ldl7LVT7dWT4xYQfaXEcV7iDv+
 VVkA==
X-Gm-Message-State: AFuF++mLev9toBVcBSP2rls8i2OLNDGIXU4C9oGcqyQi6StXwc4tkJXY
 FzDvLVbjy8AvCZqk8j5tg7W0/Qaz+V3YuYojsAdkEMQV0wz0jqUNHr5Qp84ZmGMnJjA=
X-Gm-Gg: AYBFou2IUWVYtulcymy7NTJxMBJT0IuCDPIlT4mtTEzImlzZrCSe/PcyNzPnKQOSXpv
 ESD3TLWlxgVZmlO1AIjeDHUq0yOXP4Ar3PdHlYZrHw03MnJ2GsI4uqG62CgbjXrl1DEA4ZAlNGG
 2OvvPqZiDu/tVOReCy+DeA7ttAjtviS14Yot258uRr0Lg2tr16DwlF7sl96dnaGDtzj+cx1waKn
 IRONcCfx5zBcBfLhF8wJMypJeSC1hKvMSuNHRs+yNdtwykizB4Clo5vgOGK/yfXEROXOQ/PxRaC
 7SNGJIQ8xY3wdI4HpOqfX7vj45vzXbyVQ1rZqLtWevIv0juHAwACR0KHShEFOc9Kp88hrR4Mm82
 EduKMkIdv6SowW7G2urMXznCAJSgcvVkYctRp7poWVaq68EUJ/qwZhbB609kAQJZybUV3TAIQ1Z
 ZKvaJYbWnxprnk5QgnIu5+3wq2AxyfC3YPPdqv0DdIKh4zvRPDSq0oLzHPXq53hOJsgPBulYM3X
 KyOsMvaG2SSH58gubuexgVeakmtBDQgfIWgj5E0saTCBmw=
X-Received: by 2002:a17:907:3f16:b0:c25:f7dc:2d2 with SMTP id
 a640c23a62f3a-c25f7dc0940mr1170226466b.19.1788861950144; 
 Tue, 08 Sep 2026 03:05:50 -0700 (PDT)
Received: from macbook (host-95-232-147-181.retail.telecomitalia.it.
 [95.232.147.181]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2623facc5dsm467670566b.62.2026.09.08.03.05.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 08 Sep 2026 03:05:49 -0700 (PDT)
Date: Tue, 8 Sep 2026 12:05:48 +0200
From: Carlo Caione <ccaione@baylibre.com>
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Ahmad Fatoum <a.fatoum@barebox.org>, 
 David Lechner <dlechner@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Johan Jonker <jbx6244@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Randolph Sapp <rs@ti.com>, Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Peng Fan <peng.fan@nxp.com>,
 Vincent Jardin <vjardin@free.fr>, Peter Robinson <pbrobinson@gmail.com>
Subject: Re: [PATCH v3 4/5] efi_loader: bootmgr: install the firmware-owned
 devicetree
Message-ID: <ap_dvWDuPmSNKD4g@macbook>
References: <20260903-ccaione-upstream-ebbr-v3-0-016658d0b6ba@baylibre.com>
 <20260903-ccaione-upstream-ebbr-v3-4-016658d0b6ba@baylibre.com>
 <CAC_iWjKrYxidFNW9MWuKT2DKynD4OSirA-jprGQ=NJYUxPGFkQ@mail.gmail.com>
 <ap_PgbRzwImsNwO4@macbook>
 <CAC_iWj+hcckuyaMGmEJgNkEow6S4Uv5eqq3YTUtkKQcM6U5Prw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAC_iWj+hcckuyaMGmEJgNkEow6S4Uv5eqq3YTUtkKQcM6U5Prw@mail.gmail.com>
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

On Tue, Sep 08, 2026 at 12:50:33 +0100, Ilias Apalodimas wrote:
> Hi Carlo,

Hello,

[...]
> > > Any reason we are doing the _hex variant instead of env_get? Don't we
> > want
> > > to bail out if the env variable isnt defined instead of picking 0x0 ?
> >
> > We do, but we do that in firmware_fdt_stage() that is returning -EINVAL
> > before loading or copying the FIT (so we return EFI_DEVICE_ERROR from
> > this function in the end).
> >
> 
> That might end up being problematic. I don't know if any devices do that
> today but 0x0 is a valid address.
> Can't we get rid of the check in firmware_fdt_stage() and never call it if
> we don't have an address set?

Ouch, yes, you are right. I guess I'll fix this in V4 then. Thanks for
reviewing this and spotting the problem.

Cheers,

--
Carlo Caione
