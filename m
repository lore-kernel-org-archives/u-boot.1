Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2DBAC5B572
	for <u-boot@archiver.kernel.org>; Fri, 14 Aug 2026 18:52:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6F4FB40D2E;
	Fri, 14 Aug 2026 18:52:12 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id pwzI2Ick2g-J; Fri, 14 Aug 2026 18:52:11 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A315F40CC2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1786733531;
	bh=TFft+Bo44XlhLo/+pKKHY09lorbUCR9TbkhJDvRSa0w=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=m7yL+6nsZ9hkK3WA6Uy4/lBed56ng3O2oY0ZGmBCL9fM4kmVr5dOdGwmaFgya/sQl
	 MjL57hV3u9wVA5Us10bsE1TtawrA8nLBfypzfwo1I7cttgUYEn/q8lGs8FAduPP+uA
	 g/0ZnZPrEgSh1Ut6ZJkmFnSQB6t1dFTfZzBupDwzVROuwmE7aa622ply9gyLd9d4iz
	 YHfLOJ6hSmNSD9ELt6nwf+pDwIiHO00z7abMCzhVKpZrE5e1n/9v6qbsyRCJMgNv2f
	 0BheJ81a+172g5RfZ14cDUHZOmbAWORB8+SCORZLoTCa5XGqDgO0D8ZSPUJK0UU/Y5
	 mkCu9JNmvBlWg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id A315F40CC2;
	Fri, 14 Aug 2026 18:52:11 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id CDD992B2
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:52:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B214D60AC2
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:52:09 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id sXPqBnsEF6Fg for <u-boot@lists.u-boot-project.org>;
 Fri, 14 Aug 2026 18:52:09 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::533; helo=mail-ed1-x533.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org B27B560A7C
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B27B560A7C
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=RBjjtr0i
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com
 [IPv6:2a00:1450:4864:20::533])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B27B560A7C
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 18:52:08 +0000 (UTC)
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6a0c8283146so1954867a12.0
 for <u-boot@lists.u-boot-project.org>; Fri, 14 Aug 2026 11:52:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786733526; cv=none;
 d=google.com; s=arc-20260327;
 b=E2a5rQ7RW7Tm0kvo8D3OMiFQfi7aE7ozYnDDxoeiTZgZkO0iDEip06UWuQ3xyx/69O
 +a1Zu9j2GH0DtUBDdVE8l7TUez8R0dwPbMwwN+iRNecz0hUxBDoMX0JKBvU8jQGZoSap
 ScN000Nfoa3KX/jVg/HwvOhbD8PyuaMt+t/+XGK4OubUxw1jPS/yVAft7uLjykbY5gWX
 hIh8kW1UsYOaT5yW9dIUFzmukbZNmmzGBW5ElaWhp7RA9n/E/fCBi2Ef0CLd9PPCOgnD
 B2PcQuvKGteq3Hsx5Tz+yV2gQqR02zezXj69Fs5CSnImIcoaBscoAMDfGH6pvo1zedWm
 jOyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=TFft+Bo44XlhLo/+pKKHY09lorbUCR9TbkhJDvRSa0w=;
 fh=8TbiD9fEG91wSNsvqqOput+PpnqsIRDXX+RXlsylxJ4=;
 b=EgohPJ4yNIgmPo0CjAF7d8D+vut1ctA3zlJVayMcSgDSd9E4B4lGunc0iaf7NbN4PP
 YW+IyO2cbWUFpt9GHw6PigOEztT500MNyuhTOM1ekIHvsM5fEcmmaHutO1W0tn8Ht2rx
 zGUEZxIjP2xtF2W+N27SDGvxeXZffGyMPSZ3Z5JKXHrgk802/QR/Ccs8wO/gAh8CBwZG
 ulwjA27W23//ziPJank2RYIyFpcipzdGc0U3zI/uyKglG06p8ijYmDU6SXlmzS4cDDw0
 AoGxXA1m1ZLioERzUxptteduRr6vk26TO3mliLXZT6xH2B6xIi+VDR0EpYtb+02osa4s
 4Jrw==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1786733526; x=1787338326;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=TFft+Bo44XlhLo/+pKKHY09lorbUCR9TbkhJDvRSa0w=;
 b=RBjjtr0iLUOzNOS0EAVFOzqRnmvNwRMgk5PlK7xW+Qem6tjdGFI6uI2ms3RFhrz2zS
 K7j9L2oM7D1KxUzc4kTCjv98ivB0sVNeQdFXGL2rWw/+4TcPpf9OwGqdUr2wC0NqKuN/
 DwSl8TnFmCd/o9yTOTCRGBgzFBvdtJzFZEvTA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786733526; x=1787338326;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=TFft+Bo44XlhLo/+pKKHY09lorbUCR9TbkhJDvRSa0w=;
 b=nnn/bvPJQzNwGzUFYzWvMkcSe870TlPqWtzGsuAaMuP/ZFlrgSXQqNQQc/B/EBZurE
 qImZAsBiSp/oHCbQC1KGQhRgyRC6bH1B1zYrKnBceKxp8C+OVkIv9nJg2I9LXfygMi6T
 yd13uOLV+kMScDWEp0vrfL6g2KV7qeGyXN1itFn3jxP+DQ6xpG5kDmz657p9SpALDkp+
 ERdtkp7NGcnT7byixylnWrEYZwTnSdB1nmuZ90poSylmRR1yOtiuHK4yeR4n5AXJB3nC
 uC20YKlPok5J7fVZiL0OWGqqG54GX4LDUKWF0NhuyYYqFTC5Kse3aa8irBnjTnM8XtGa
 kRWw==
X-Gm-Message-State: AOJu0YzpsVAiiQAH8tdDB94OwKhutOGzN+h8vPrUfWW7cWUB6p/ggCXM
 vabpDzOlz74wpVRk/WHX2rOG6Yy/S9/Lfje1IsBveOxL59pUf7jGKRwFA8DcIy8g+OE409P7I41
 8PCjB5d3zI72gr1fJbNxO12zqAT02rPHCdVoFMtGZk5C3BIJQMDM=
X-Gm-Gg: AR+sD12YGc68oqERN5qRV9HuQPQRBDRcR/qN0znLLWd+DG9OPaUjAjOR7K7VxE0pCbB
 XZ1zb+9uuRyQxzgVI+c1oCIkPfoEQJu/B5OolBhn6Olrk/Y+dZ+eV8tOX99N+Gn9veM8zcrRJzf
 ff3WXWRodwlLS1ETiXXOv37dLXKrWXkVWM8V0YqdXOi4htWEbtc1WWNHYah7vHhmK4z3spmvV0I
 //VkJ6Xv0jZr9/z1W3L5MprCxMB+b0Yiiw0c4tWBESNSUK4TyYbJpYOxFvi6KVWivG8J3YZj2Xw
 33OXJQkYaxpcpOEEh9w9fW1TonxvsIXeRmD2ya2T1Yc=
X-Received: by 2002:a05:6402:4513:b0:6a0:926e:f907 with SMTP id
 4fb4d7f45d1cf-6a38a8bea9fmr3928373a12.1.1786733526469; Fri, 14 Aug 2026
 11:52:06 -0700 (PDT)
MIME-Version: 1.0
References: <20260811105314.3837228-1-pranav.sanwal@amd.com>
 <20260811105314.3837228-7-pranav.sanwal@amd.com>
In-Reply-To: <20260811105314.3837228-7-pranav.sanwal@amd.com>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 14 Aug 2026 12:51:54 -0600
X-Gm-Features: AUfX_mzUWi-KaQn5_SKhz3Rzw_nj2fWGJZ_q4G7ZBaf9xru9orqtJmZd8GimFdk
Message-ID: <CAFLszTgR01mHsw9CAoUo_DT7Y1vW7fDxdi88fquWOW3VJWb4SA@mail.gmail.com>
Subject: Re: [PATCH v3 6/6] gpio: delay: free already-requested GPIOs on probe
 failure
To: pranav.sanwal@amd.com
Cc: u-boot@lists.u-boot-project.org
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
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 2026-08-11T10:53:10, Pranav Sanwal <pranav.sanwal@amd.com> wrote:
> gpio: delay: free already-requested GPIOs on probe failure
>
> gpio_delay_probe() requests each wrapped real GPIO in a loop and
> returns immediately if gpio_request_by_name_nodev() fails partway
> through, without freeing the GPIOs it already successfully requested.
> gpio_delay_remove() does not cover this either, since .remove is only
> called for devices that finished probing.
>
> Free what was already requested via the same gpio_delay_free_wrapped()
> helper gpio_delay_remove() uses, bounded by the number of GPIOs
> actually requested so far rather than the full gpio_count.
>
> Fixes: c866f2f197e2 ("gpio: Add GPIO delay driver")
> Suggested-by: Simon Glass <sjg@chromium.org>
> Signed-off-by: Pranav Sanwal <pranav.sanwal@amd.com>
>
> drivers/gpio/gpio-delay.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
