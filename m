Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06D0CCA5FA2
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 20:33:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C8D060632;
	Mon, 28 Sep 2026 20:33:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id j-6tboPDsyT2; Mon, 28 Sep 2026 20:33:16 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 859DD60615
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790627596;
	b=J2lBV2XsEyAf27K50+XD+FkwaEJD8mjoiQ6oqBCSb6rCJcceML2Obh44+jejpkqL1C81
	 VdRQOxvLwYmpuYivLdRWq/VRsV31Psjr8/j80EsdI8Ng2uZRQHIJPpJGjfUVwcyVTPFpG
	 bv7Xj+oB+GX99HYRAmVnyloRBePgEPAW/v3vvDGD93qu1Wel96tH26L11hZ2X+ydFKW6F
	 J2ZHpmNhm4iZgluGn9YsdRJV8W4j/R6N4WjPVag/U6qnBsJwp5fW+3hsrGgFSsuP+g9iu
	 svie+9upcs8cyme/95IyR0K/MIbnkJ97Z7owsLM7wDjHHYE8aJMfA3gcF4j66DsSRvA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790627596;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=IUE+YFj6eUeeiTefe4cmvXY+705ezdO3kMa0+NXu4aA=;
	b=NSNPN/qI+MRmrYXRYf518khF35hXqhYWGUHZJDy7/mF68BVtYiy2xRk16xkV5lkaTd9P
	 G93cul2ipcl5KNObARgb2S8/hoMSFFvHzR51KlCXHNL3SrC6WeBGrLYqCvLT9K8W31+Jh
	 TlKHm2BLyUCQ+T+VXn4YaiIK6gnW9wOYaPFYpnaebs8ukNW7pqPIt+At1ai5tAnpi0TUh
	 5Yc6/DNtAz79tyI+GvDEg8Y8v04pGB+0gbk2/TkBWXx7fYxGdw3xJa1U0Q8vAwUsYamq5
	 44G89Lr7uRQt5ZTRYF5VuuP6zwZAD6Y5pD4NNUgW7e0fyZylr8auI12qA9EpcxGADSQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790627596;
	bh=IUE+YFj6eUeeiTefe4cmvXY+705ezdO3kMa0+NXu4aA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=TCE6ny+Ea5VaPnm9vrT6ueT9gJwmjvw9GSTzbgBBT0jHenBoG+noolDyS4aIme0uA
	 Tofgtg0t3pHRSoa4VilG+RbYEyO6GfFd1O3GVHXK2kO6mtUJE9OYNTLMirlEbmgGhV
	 nmmfd6kQ76uyq5JWFoDu1FYE4ruOsUQ/JzZGrO1gbQFC53KJ50ji/ZwonSiIPek3o9
	 B35ztenBBSosKFOAX3o3M4yGfPkT7YDo3PifmPcrA1VGmvpuBKFTa0Nuxbxc2uc2gX
	 FHXe2DIpftgpyftjJLZg+p6J94wgUbi7aQkwxxxxyLsPm4oJj6CJw1wqKhpPrF3EGt
	 Ir+x4I2yZmIdg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 859DD60615;
	Mon, 28 Sep 2026 20:33:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 18B99D1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 20:33:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EC9254018B
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 20:33:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id UvnDkf5xSPSu for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 20:33:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp2.osuosl.org DF43A400B4
Authentication-Results: smtp2.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1790627594;
 b=QOorPfP3dA2ZJsCYinsbgSVb7ZKhlbUgxzNpx1mb4LNMxq+ZmdKfRT6bQ3dYVodTxss7
 /pKBQae0PMnsl/HwAMetoe9RD6UqIZ2spP1WR8fjWLyI4a3xQ38uEwobvIt9krrkJdC5r
 1uAfTPg0UJc/1cjFwsJjwqvrm6ghOr0reRQa2hs+WThx/ZNwraEa7Nnig0oFbTD2wUMu1
 +mWKO0oQrPq7ulWduvWUOJWUn+QbljQ+RheEBsFmthc2JFYGyn0axXChIfGgWMAR+FqUc
 4FKSpPnkwCLg5vjKUlE45Nyy2oXBqua9U8HVjiOHMCYGy/4KeHVI8t26qL5FsMX0OaA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790627594;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
 Content-Type:Content-Disposition:In-Reply-To;
 bh=IUE+YFj6eUeeiTefe4cmvXY+705ezdO3kMa0+NXu4aA=;
 b=tNdDm87YUTH2dP3cwolGa3bPfoL3IY1okj/IC2e94dy5QpQy4RemKkmLOHBBWwQCp5Ng
 aPjNtpr1rAeL0yB9/hOU6dKiuhTtjgj1JKyHxmaCvKZWDzAf2N+i+72CvXUJvTOdxJ8ck
 Jgzlwqup8watQJPdPa8sJqcA8NgJYVATkmBckzLlkOXjJZTUyYkqeKU8ulkEHf50yDdWa
 h6UEEBRlWgnUCY0mWEXwnZB0YPEKYcCmMQJALO0JIvaJ76imOnhZFgSJmPP6LBWYbViZI
 RYA0bilCPsBkTrGPDnq/iSHkqhH5UaSjIrbxv9p+9EYdRiNOr6+aTj9Rf3RBfR+Gsxg==
ARC-Authentication-Results: i=1; smtp2.osuosl.org;
 dmarc=none header.from=baylibre.com; 
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=DkcVjSdZ; 
 arc=none smtp.remote-ip="2a00:1450:4864:31::11"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com;
 envelope-from=ccaione@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=DkcVjSdZ
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com
 [IPv6:2a00:1450:4864:31::11])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DF43A400B4
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 20:33:11 +0000 (UTC)
Received: by mail-wm2-x11.google.com with SMTP id
 5b1f17b1804b1-49e6b885ef8so19657355e9.1
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 13:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1790627590; x=1791232390;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=IUE+YFj6eUeeiTefe4cmvXY+705ezdO3kMa0+NXu4aA=;
 b=DkcVjSdZPzhO0x3aB60rhDIJ4KEnyJhasbRje6czSHQPGuELXNAByyPKXpmgHbdCcA
 7ST/8XBBQJgU6CDVEOl0J3WqZyfjOd7TDizICRZiSVpYe+NIesStwnHGQRN2cQkWOfTw
 97JsLnV85LgYfXrsCUzMR3rMtmwmTV5YxPCL5u5g5wZI4Jd5cFR8fBBeLcTCoQxgAhRq
 HCN+ENpTEoRx3f07RzvFUeCuQ4sg8TUhSQr1QaQXPu7VQ2n5BsiXml+3SA0pLZEOGwA4
 rawcEtOq8HRxpQOvmY3iAfon3A5U2rjpHgeH+sD9uWt7trr819FURnoDYLJ3NM4ZmVwf
 nLOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790627590; x=1791232390;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=IUE+YFj6eUeeiTefe4cmvXY+705ezdO3kMa0+NXu4aA=;
 b=ZsNaXVw614m6F4myLyoyjCnaNYyFcKFxoS507GNuXasxXP72RGRgMmFIjG9ecFdkWo
 8xzXxVA5mLo2eoNLRIWeHO9gCHo0XJTnKwbZDdp+iNVbsjWfk7IyCY1iriNVFINBUpAW
 wTkr9oTWpEJIiFfdU0ywJW8nQK5oe5MRdzBNQdZtAQR52NswW5kMkIifdCNtN4RicdSi
 3avfREPrn+KzNHL4V35DE9u1G41F7OsjfSANMUpcOkj5jXpa9M0TLbzzLNx06tSYbHci
 AwR2PZiJ3zngm6g6vvijSV4jUQ+HBMF6gi+Lf2kO2+JQp8czcDGYMJty53QwzRK4ZMW7
 oZtg==
X-Forwarded-Encrypted: i=1;
 AKwUvBz4a7vd3ZzxJ/xzbYFj/7lg+6xHjY6GS+XkdsT6uSsFb4sULlB6g8cZJHaKRqqTfex00C97xBY=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++ni+cm+G1LrGDPXdodgWbwWnF816f9fqDD5z7qZRRGNCdEje7Pe
 T2k7DYMI4EviLYE9Nzj4n0YrSZJY8GaEviAxSv5umb4sbJY58kL/j7G+zWgBO1gmZsE=
X-Gm-Gg: AYBFou2iZ/10YleQRbjHRjk1Qpm1/A6G6qIv2a+d32sJK/T+nJpQ6ykX/TekPHgHIOE
 0U0zi0ZRwKuFdfM3550wqfrHLoRQ259ZRK905H0F+XNKd8DyzoHEZNCpoQwXZExAK8mzFLnupWQ
 29BubuBPH5JY+0EtpwLvBF8ky4kbMlIQpJVE1Rj8FXOdMdeuxYzvlAjN5aFfF/rRiPAJixzC+2z
 WdLNCmqIR8UP/8f8pTMEPGjGvvc7cWdpCXN2RazMiUv5El5/EAwxsas0p8vzF8T8AGiwVfLpUCI
 29erHxidJKw6155W7/32YIPcLJ+IDcDCUuOPm+C4+7fcuwMX+CAExpsSOCrmWBTqIsLkWFKvYhU
 HHxLmFO6AtAnppTKf6H2SeZ5SQ9FgiEnbl+hWsQOffJxk6+Aau58ot5bNhCIQmnPoYDvhHmXH2r
 9p/P0iY54roI3vPz+dklM3a21rlTBTEWhDocUOHGndlCwlyjiGXF6kAmA6+N8zFjzb8ezQJdX8s
 6uGRHbzKnNdnJA8CUfy8+vn04p40gBIj0PsXwFmoI9jo5BbBrQZtpWM1DUGhgIfC2I66iaDqRBK
 q3wevcgullE2/RlKq+kUIx0=
X-Received: by 2002:a05:600c:3515:b0:49e:7a10:1b71 with SMTP id
 5b1f17b1804b1-49fe66d089dmr242894945e9.11.1790627589594; 
 Mon, 28 Sep 2026 13:33:09 -0700 (PDT)
Received: from macbook.homenet.telecomitalia.it
 (host-79-45-166-197.retail.telecomitalia.it. [79.45.166.197])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4887a6450a3sm27999961f8f.25.2026.09.28.13.33.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Sep 2026 13:33:09 -0700 (PDT)
Date: Mon, 28 Sep 2026 22:33:06 +0200
From: Carlo Caione <ccaione@baylibre.com>
To: Heinrich Schuchardt <xypron.glpk@gmx.de>
Cc: Ahmad Fatoum <a.fatoum@barebox.org>, 
 David Lechner <dlechner@baylibre.com>, Julien Masson <jmasson@baylibre.com>, 
 Vitor Sato Eschholz <vsatoes@baylibre.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Johan Jonker <jbx6244@gmail.com>, Jonas Karlman <jonas@kwiboo.se>,
 Randolph Sapp <rs@ti.com>, Daniel Golle <daniel@makrotopia.org>,
 James Hilliard <james.hilliard1@gmail.com>, 
 Aristo Chen <aristo.chen@canonical.com>, Peng Fan <peng.fan@nxp.com>,
 Vincent Jardin <vjardin@free.fr>, 
 Peter Robinson <pbrobinson@gmail.com>, u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v3 1/5] efi_loader: bootmgr: preserve a passed devicetree
Message-ID: <arrMZNzoS0hrDuSG@macbook.homenet.telecomitalia.it>
References: <20260903-ccaione-upstream-ebbr-v3-0-016658d0b6ba@baylibre.com>
 <20260903-ccaione-upstream-ebbr-v3-1-016658d0b6ba@baylibre.com>
 <2858ec5b-40ea-494d-8566-64eea06a1e89@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2858ec5b-40ea-494d-8566-64eea06a1e89@gmx.de>
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

On Mon, Sep 28, 2026 at 20:45:37 +0100, Heinrich Schuchardt wrote:
> On 9/3/26 15:09, Carlo Caione wrote:
> > An FDT explicitly passed to efi_bootmgr_run() is currently replaced by
> > the FDT referenced by the selected Boot#### load option. This makes an
> > operator-supplied devicetree ineffective whenever the boot option carries
> > one.
> 
> Hello Carlo,

Hi Heinrich,
 
> I do not understand what you mean by the term "operator".
> Do you mean the end user owning the device?

Yeah, not a very good choice of words, sorry about that.

By "operator" I mean the user explicitly supplying a DT for that
invocation, for example with `bootefi bootmgr <fdt_addr>`

> What makes you think a device-tree entry in Boot#### set by the user owning
> the device should not take precedence?
> 
> I cannot see any justification for the change in the commit message.

The use case is a one-off override: load an alternative DT, for example
for debugging, while using the existing Boot#### entry to select the
EFI application, without modifying its persistent DT setting. Currently,
the explicitly passed DT is silently replaced by the Boot#### DT.

My intention was to make the explicit argument override the stored
setting for that (manual) invocation.

With this patch and patch 4 the full order is:

1. Explicitly passed DT (this fix)
2. Configured firmware-owned DT
3. Boot#### DT
4. Distro/ESP DT
5. Existing `fdt_addr` / control-DT fallback

> The series lacks documentation which describes how device-trees are
> selected.

Yes indeed, I'll document this better in the next revision.

Thanks,

--
Carlo Caione 
