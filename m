Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFED5606A32D
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 14:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=CI8mjik0;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=A562zSl9
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 91A6C606CB;
	Wed,  4 Nov 2026 14:01:24 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EacVbcr64T2f; Wed,  4 Nov 2026 14:01:24 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D05D360628
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793800884;
	b=MPG/gqsGthesrWvb6VmRbwU24Q+N+qzTTXhtXc5XZdhcdbvEalQGY7a0gE/WAuIK1u/S
	 z2xI/mGNLikDj1sdRJ5hWWsVhj/4gq2P+jB8yaZfNAxixf2Qg2gxiHN/7EMZi2SbXMnmG
	 LYPvw3DhTH0oDI59JHcpX3c3e1zjzPFIJRtDqI1Ssz4noyvz3SOeYllUe3Fv7lVaaf7UK
	 L+bR8vwkIZEuzhARff3yDussALKGqrBSNdMMJsGzRM4nHv/smPP4AzmrIAFC7FBsiXbSW
	 49jtdDgFhyiLdVoBIC62LuULxAHdbePtiwIVy70RoMUPJtVpv6wzGiQ8vr3VwMwck/w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793800884;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:Cc:References:Content-Language:
	 From:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=KFd8iN9Exs/rEkEIOZnkvfQwfgdG81cCF3N1TuobQtQ=;
	b=TFBkow1h47r/wDHI1i/oINdQKC/3fosGpu20MOtJftQVZ1+G949Ujh2VJ9weZuG4Sgop
	 Vl6nSRZkwTE47T5dvFwTsJronJG+c3Lg9hc5uH5HBin21GplpEAnnS1FoaHCDN7uJo+ok
	 i1XzeTX6H31mSrlINnkzviNZJF+yMUeeyAgEA95BDrIl5GhBW72yK4Cs6SR/OgYl9Q8tr
	 L8GDuqOWyJ/dfjzLi9jnjqQ5G07KvAkApHHaIbGFc53xRPUflerdIbx160RWVmL5Wczgp
	 9CFuYHZ575WN1efhwvD1P1XBnAgy6EIR2JBPbljwSWC7UtR++OIWp0iN/lBl/i5KNpQ==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=none header.from=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=A562zSl9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793800884;
	bh=KFd8iN9Exs/rEkEIOZnkvfQwfgdG81cCF3N1TuobQtQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CI8mjik0YvDkYybnHoM12aWzQIWHwC4BgiuQoZxZGS7Ga+/+3UqOUbr1s9zfoy1vw
	 OHHP/o7X+/TxhivOkXJ+OUNf7fE4JqVpif44bvGx6JEmvhIi35lxfyWzDnPRYE2nDc
	 Q+beYq81P97OhODt3iEzxAK4Z8yXhSNR1rjdG/2kBZzVzYGb6jCEMxlkqAZSulRpDO
	 HOSGiNtecC7F3oe0tIA5RLZtVs8Lzhp84Ur7l8yf84JNVSWPEBudldxpwzS3tt1WGh
	 eaZHE6Js0qGCs9/PdLSS2xnzT36mRXXQXICq1Dk3eYJGcaafwLiotvgFRkb7KE+Dzw
	 xrRwJCdHq8Zww==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id D05D360628;
	Wed,  4 Nov 2026 14:01:23 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 37EEE34D
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 14:01:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 34C19605B0
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 14:01:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id gIP61QDHd_NN for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 14:01:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org D2BE660628
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22b"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793800881;
 b=dE1w0foW7JvHx899SUwPwGr+OvzJVtNO/bilm82HreeMvQ/sn6iYxJzraEspcfyebW7A
 /6lrIv3KUhENQ1CkAlsiKVfIV7VF+VmZpQ8rQxrxzRzQhsI1jCevdiHD/W2Vp0Q7hPeWp
 AZ3CXEyf35D8MVSPT1LGmZAZnwWzqNe1Sc7dLjMKAzgR7IlRJmlgwCkpl3PwgDgpISrzo
 BRG2VWGU2mf5U3wSreswuLw0IZq7G70i9tzfYKCNI2gjU/aKN6SAYuMa+bURYgWyvcoJm
 LFIrXvnx6/okaG5SIR+KB5RbGAT47nKYSVo+jC4fO/BLpVN62P21HXY+t7HmaDg3cdA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793800881;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:
 Content-Language:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding;
 bh=KFd8iN9Exs/rEkEIOZnkvfQwfgdG81cCF3N1TuobQtQ=;
 b=oNuD57ClqmD80/MT30Xinm/pT9GArBDqcZPlL1gFyEg4FSNlYoStIWv7p3fePNHnyKqc
 ynTJhZvjU8+/wxRjoskH97OQe/ga8+2QySR0IwaiwPpld+XOJdCFuKptECvTCo4Wqir6Y
 pRhuUaDhIcS6ChGXN0g0GhtFWUrqv6QQb1pQvFJ3wEqYTpDdxnfOIIYy8y9xHSFvhOVPm
 /4Yz1/+LreoYAl5wLLAGlpP+jIcOKc0WIblfBl4QOhJHsVLlf7o75wBNIF5RlTm3mDC+v
 pR3XtI1wB0/wfMQlCryjtVDYdhlJWr3/bk0uVWhrenwLIQAlYtHU202tCwbG1uZ5AjA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=none header.from=baylibre.com;
 dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256
 header.s=google header.b=A562zSl9; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::22b"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::22b; helo=mail-oi1-x22b.google.com;
 envelope-from=dlechner@baylibre.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com
 header.a=rsa-sha256 header.s=google header.b=A562zSl9
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com
 [IPv6:2607:f8b0:4864:20::22b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D2BE660628
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 14:01:19 +0000 (UTC)
Received: by mail-oi1-x22b.google.com with SMTP id
 5614622812f47-53c156ba662so354990b6e.1
 for <u-boot@lists.u-boot-project.org>; Wed, 04 Nov 2026 06:01:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=baylibre.com; s=google; t=1793800879; x=1794405679;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=KFd8iN9Exs/rEkEIOZnkvfQwfgdG81cCF3N1TuobQtQ=;
 b=A562zSl9jEqGLNEJow+e8Od4kJFPJ0yzMUsOseBT+g1v9BJ1mMqMCQGDE9nudfIZPF
 ohyuo1OQIB6Znz7k0DNawakR9hgtQx1ue0WPyeD5n7mQJoRLEA90SeDmVf9QdWPD9wRV
 VBxU20LwIkOzchfeuWb+xTB7lI300DmMBava7zXXLuC+oh8Sl7pZ8i2E+NhYF+cN3e6i
 25Wk4cUJ2aneNwJJz0V9H+nNtb1tFJdzdFX83IY2wr2BRDMxEOpAoL8APOlZtiPXn/TJ
 kfCWgyctOEDmgmW/HarygOu1YFvPLK4v5CuK08kjPPQL3seG0p/2fawaU65NcH8N84st
 NGRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793800879; x=1794405679;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KFd8iN9Exs/rEkEIOZnkvfQwfgdG81cCF3N1TuobQtQ=;
 b=VXpUbarvUV/bDlQwTeMk1N/KB2sm7MC1DHS5wX67iscUz5Tp6KCeWsZ6lbcgv9jJn9
 DiTtFgGpGMm6D0K9y4czRVjq3ZNuy68V+yiWjIBHQdw0950tI7YvJmo0ynpOEawGEyeV
 yK/xxHa9TUZDSduwdYwAvUgaK9UMxBeBJJ3zMmNMWr4oEj3+x2DrGQpnQwdSkFSn2Jm/
 No2Qj3YV6lQ17Yf3ca1DRVoKJV4fFfuO5G8fGaoEn8NLkLcuPS6g319crVDVLzFot56J
 5UWWRBE9fJXFGmustdkhH3mbie0sti+hBa1Cq5mCLnu7AkrmUO4Wj7JTeM3sYijj9bQm
 ndPg==
X-Forwarded-Encrypted: i=1;
 AKwUvBynrziNe+WGZ9r1CT/LXPSTdSRhVrcWzY5x38NxuzaWN9r7rK/KE+tNUSdGNkqiquLpMSdjtfE=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z8vxp/3/N90h8t/V6LkonKUSh6M1VnKkDAk4nhePhNjSwXRj7E5
 5m0bc1xh7Zo/UE4P3u8qLbvrNqOcAsKVrHYLszLqOH5gCkjSGf8WlURhmbKae57EI1I=
X-Gm-Gg: AYBFou0/uO7BPdsqZFOBx4TI5a9nIxLqMyQe/mqw4PxPG1bUwSLZep6/Pejt/6qHpTR
 h49uJhDffBAFARiR4gOs4t1l7aogLwNYezwNAip5u6GrCmcf3VrGLGGfs3CeFSGTeO5twN/6oqE
 jxy58E4du/cgmDfufx3+NmwGSEd8uemSdpXyNjmvLgw0yu+XuPJuMWD/skbbhc0JT9SH+aFA36I
 PbulpGaBSsGjUX31/pfplmBjlt1rh20tNXiPNEN5KBEnR7UUqPsvZRW182k598RiY8/UK66fKl5
 8qZzqM1g/DZF71fDKEuVbS8i9IVYXL+e42pWqri/Hc0hUUArSNV1L7NZ7BgbPyf9NoKa3nQgrz/
 WWRL1CrKOzaCKACFsO7lGXrL6ahFW3ptHWRxFqiHXEnGtpn4ZuxhxzbTqM3VASLKqyV9Nq4Jfl2
 Q9Rlflklxn7v8IgX1JE6p3KCZIuHw0UjH8HhGTpOZKQGyM/vTjuOvs/pdy2N2sRF4GBLhvMmc1e
 uptI/RhvkoqRGOiO5pKaFJ4nx+EhvXyArP8sr5VgqiOVOZATX1+hAFnsmEpuWiZ8TLOEcoI9qvl
 S1yuGtJ0WyKvDYApHQY8OgY9PBPpqCj3MJFWUc0br7NRRlYXEnzFdnnEbCgNYBOG7rhDUKAEF0Y
 =
X-Received: by 2002:a05:6808:130a:b0:53c:7298:3591 with SMTP id
 5614622812f47-5640db0e29amr10872329b6e.1.1793800878946; 
 Wed, 04 Nov 2026 06:01:18 -0800 (PST)
Received: from ?IPV6:2600:8803:e7e4:500:f563:d5d:661c:51ed?
 ([2600:8803:e7e4:500:f563:d5d:661c:51ed])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-567a9f400fasm1659323b6e.8.2026.11.04.06.01.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Nov 2026 06:01:17 -0800 (PST)
Message-ID: <9af0101e-e133-41a4-b0dc-b1d215bd7c83@baylibre.com>
Date: Wed, 4 Nov 2026 08:01:16 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] mediatek: mt8189: apply the DRAM description from the
 bloblist
To: Tom Rini <trini@konsulko.com>
Cc: Simon Glass <sjg@chromium.org>, Macpaul Lin <macpaul.lin@mediatek.com>,
 u-boot@lists.u-boot-project.org,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Julien Stephan <jstephan@baylibre.com>, Carlo Caione <ccaione@baylibre.com>,
 Liviu Dudau <liviu.dudau@foss.arm.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20261023-mtk-mt8189-tfa-fdt-v1-0-f86616860bcb@baylibre.com>
 <20261026154340.GA646438@bill-the-cat>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20261026154340.GA646438@bill-the-cat>
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
X-Spam-Status: No, score=-12.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/26/26 10:43 AM, Tom Rini wrote:
> On Fri, Oct 23, 2026 at 05:32:42PM -0500, David Lechner wrote:
> 
>> On the Genio 520 and 720 EVKs (MT8189), the DRAM size and some memory
>> reserved for the DRAM controller depend on the DRAM fitted to the board.
>> The devicetree built into U-Boot can't describe them, but the boot stage
>> which initializes the DRAM has this information.
>>
>> That boot stage can describe them with a devicetree overlay in a
>> Firmware Handoff transfer list: a memory node with the DRAM size and a
>> no-map reserved-memory node for each reserved region. U-Boot already
>> applies such overlays, but only when the transfer list also contains
>> the devicetree of U-Boot itself.
>>
>> The first patch makes U-Boot apply the overlays to the devicetree it
>> found by other means as well, so that the earlier boot stage only has to
>> pass the DRAM information. The second patch enables bloblist support for
>> MT8189.
>>
>> The first patch only changes behavior when a transfer list contains
>> overlays but no devicetree. As far as I can tell, no board does that
>> today.
>>
>> Tested with TF-A BL2 passing the overlay on a Genio 720 EVK (8 GiB).
>> U-Boot reports the DRAM size from the overlay and its devicetree
>> contains the reserved regions. Without a transfer list, U-Boot uses its
>> devicetree as before.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
> 
> I'm wondering what the status of uptreaming the TF-A parts of this is,
> and why we're in this situation rather than how the other bloblist
> platforms work (as I understand it anyhow) of either providing or being
> provided with the device tree, updating it, and passing it along?
> Conceptually, I'm OK with this but the support of just passing an
> overlay from TF-A needs to be accepted in TF-A too. Thanks.
> 

We weren't planning on upstreaming this to TF-A. Vendor firmware currently
uses vendor TF-A for BL2, but our planned "upstream" solution for BL2 is
only DDR loader + U-Boot SPL rather than trying to support both upstream.

So the most important case we are looking at here is:

- DDR loader passes bloblist with (only) overlay to U-Boot SPL
- SPL could go a few ways:
  - pass bloblist unmodified to U-Boot proper (what this series proposes)
  - add U-Boot proper control DT to the bloblist and pass it
  - have SPL apply the overlay to U-Boot proper control DT and pass it
    without using bloblist

I think the second option sounds like the best.

