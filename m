Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97334C79F9E
	for <u-boot@archiver.kernel.org>; Mon,  7 Sep 2026 12:25:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4033780C9C;
	Mon,  7 Sep 2026 12:25:53 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id ljCCJFotHaR0; Mon,  7 Sep 2026 12:25:52 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 595C880C9D
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788783952;
	b=f/kxh1y1L8mGjLec8YL5vO6hnfdLlqFAiGEHivYwtp31DwI4pIuw+6eWaGzqGT3mqCCF
	 SfpxwfgWpQNqnygU2R4nNzV9PlAtmNX/2Q/U7I2DybePDVuCHoZEGUTzdirNjCBGwu9C6
	 H2tYKtoT6F+UfbPGNspt+pTGC2D7hOKaxztNYW4cZBDouXwHCYy+rMt0ed+jiT6PXl/TH
	 MnOldvlyOmSS2/OHGsyUgTm9IRlqfcLlUHwLAXwoyQ6bYvEoIPYIyr62RjJCIOFoS0KD/
	 dDNpcoXH1LYLJ0RAKg8B++vEZIWiMLjfNjlluvwIG24KMIiVvt49rxLYOqwG4mrXGjw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788783952;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=DinF6L5tCO8w9xnhTeC9FoEWwHFbbcbvfZ4yWVeupOk=;
	b=mPJbunTuPFcsnjfkJJtCHKFaqkmtJYruBluzRfZo6iNIokgOQHYVgVbYVUId6nUdhZjx
	 at/tMxYyy5uBMz3aBK2BOlNun9qPyCdDKIaDfhrRhrD3dw8DttFeSCxE2ltaC9740Qqrl
	 pyacbVn15GV1pwbWCuxpIi5QaJzZ1cmZYho9E3re84jaZ++y6A7dDG6YcIPbKM/6W+rmr
	 jKU4QyEiHa4TNEo+qUAoM9iFv/5SLOyjsVceEzKnrGDwfCZ6tLNAXvWf54VZdOPCfCAHV
	 KxanldHHYZlv08HsCC6/3SWHbUX0yu7AWCtEBC7cShWvCrT7YrdlpiBWnJZRcXjwfwA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; dmarc=pass header.from=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=IHLSAKPM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788783952;
	bh=DinF6L5tCO8w9xnhTeC9FoEWwHFbbcbvfZ4yWVeupOk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=RX3AFH/R1njLSaHjvsNAlWBFs8TyRSUEWAOVvdCMrZYlOUtQjS3Xgo5AIwPMf8u0V
	 2tA8C1X8DlGBVoZn0SdwyT4FWqhPC+kwEfdW2XPCgzVapTCjMNTSQVOZGhipLrIf+1
	 rUDxILyTH2HtslUfgZxP2eTFnXj9eOuFnAlYGkN7H7E3vb2TUgqOWA+XMJFoP5VCs9
	 mOm8GJ6gh7MWPic3Be0mecvwEuCrvnRvTI9yk8JYFb3sLlpfEgBTM9PTI6pMp3mHri
	 U4uhmRviM51al/zGmx2UAjkk/68gMAUPDBJmXb59VVn8HvtbBz6QFQgyUXioM3BMAY
	 jLnjI/oGvaHEw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 595C880C9D;
	Mon,  7 Sep 2026 12:25:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 6FBF4AEB
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 12:25:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 54AF080C9D
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 12:25:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QR9BmzZsE18p for <u-boot@lists.u-boot-project.org>;
 Mon,  7 Sep 2026 12:25:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org EAFAC80C9C
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2607:f8b0:4864:20::1135"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788783949;
 b=spmAAQQQcUu1tobGLTmrVQsLdrdhDg7mf0EV+7jKJ5svyDUkluP+UjypFxVW21MWd+ac
 NY1RfLutW/vovoJyNZ+Np2C9Lk+ac4cXQNw/0SbPfziw5kuPahFW4FCzKBMn7/F0sCNrs
 PU8cG1yWQmLndrGNXbIrL3aPCglk/NN3iBHBEuZelm15D2VaGq4wBhM5VTC+1kg+zv02M
 7JTVRSUdWlLMgX7uqmuy3AJvQDNTeRLe249OV2PsMw5GQvXhjE6/ZRPoT0DhZsaCbbKTV
 z6Hzb41B+BfqguONHMyu4egbBhNKVmMM99XhHjSIOvFPw/Me36dRD4v0Wg7cqYVSZ5Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788783949;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=DinF6L5tCO8w9xnhTeC9FoEWwHFbbcbvfZ4yWVeupOk=;
 b=oIXAsMcRUwuJ+tNWqzlwX3L/Wnz7t7C8b1hNQXWkZd4AU7iyAQq9no8Ej2vb4tLXJOx7
 b71K2y/5V+v3Yw0PmH4QQZh1PAeCFYcyswGnSHCbcDZ3XFj9yOrA6/zS0e1tq4iZhtR2P
 pDuo/ipSuD2W0xTlkpEeVOSBqBIMPSGCO4lpbuqk/AAwXW+pdS6XOF92LGaZcaJ4JmULl
 w9sWKN4G/u1YVsVpktOIvU4z+1MKKt3tkFourbC25cooNtl/nUcjopCtp6XIUiFvGitc3
 at6eKSl0IyAdkwyqKa4S6D4VFgBDaqMcbN4VTdeo4M1U0vOAlNAi7ESDtOzWzKyincQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org;
 dmarc=pass header.from=linaro.org; 
 dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=IHLSAKPM; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2607:f8b0:4864:20::1135"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::1135; helo=mail-yw1-x1135.google.com;
 envelope-from=ilias.apalodimas@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp1.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=IHLSAKPM
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com
 [IPv6:2607:f8b0:4864:20::1135])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EAFAC80C9C
 for <u-boot@lists.u-boot-project.org>; Mon,  7 Sep 2026 12:25:47 +0000 (UTC)
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-855a66e5b5dso26249237b3.0
 for <u-boot@lists.u-boot-project.org>; Mon, 07 Sep 2026 05:25:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788783946; cv=none;
 d=google.com; s=arc-20260327;
 b=RYnxZFMBzy8u3DUG56w7IjCrlq0WoCXbtCNfOJsDdbrItf75yH1QrozePCGhuJQHjJ
 4Tuq90HvpaL0v46p7gwGwWQ9Z9IBvbQBhRP3no8cPlg8IgjBNoHfuSJ1Xyn3I+UnoXMj
 udIQpKPf9GVlqRO08Rj5dUedQ4Mjd39LNKJEJZjnE3hqw/GlOmdRuRxUy+JK83X1ptab
 /S9pgFMz7WUycqXE0mvCJjUfI1lptiCAENJlssm2NTwQeG2jXBbhHWdX/GvteN+qgpRw
 2mksFWAafv/walJaeULI630m4dIxFgN7fcZ6xrrUudLrmiowoqZ4qExTXwiC7ieWnnQM
 Wtjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=DinF6L5tCO8w9xnhTeC9FoEWwHFbbcbvfZ4yWVeupOk=;
 fh=5ukjT+t4FtjeXJf5DzClNyw7hLCVACfO5sLrULbT7X8=;
 b=pVSIkRam2sx2BO/7PpM9f9Q7V1en/6cP0tQJTdS4WhVsZOYhImPw/6X3hcjFge5Afj
 o4T+bEa+NzWzFi1QPlrqGmN8xH5UNXwUTh7SX8WKb8WF3tN6pPMsR1SwhYbfuZCdQfNw
 vjG3c0cVhs+agVKAj6deKXJHr7rzysSTs1PW1XybnCIbXa0v9sqUH+HxeglNXJoaMaxn
 Hclg8TxZuq7pbbn7T/aPGFCjYwCuAtqC6m/7lLSz92TY9tWjs3gmFUy+6PMsx7ojdndi
 Diyj/aq+4k0ITljPwqe7a6sC7FXviBWi9RXoCYiFMZGXmd5qXKk3mf5foF3VUVkryVMp
 BO6Q==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788783946; x=1789388746;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=DinF6L5tCO8w9xnhTeC9FoEWwHFbbcbvfZ4yWVeupOk=;
 b=IHLSAKPM5aSpOxn1lDMFL+fIeTpcq7W6rZkw+UdeFY2mEwRPQ77X+ymF0lxAFdPd05
 edG4dawNN+ZIeJCHttN9y8KrEB8lU6YqpXToJgm+bARCoP0P87b/darPouIbyPw3KhH+
 En0cpwULEt8DPHdaX//OFSG9/3DXzqqxbPk6qO3nDU8BmJ1LoVIygMdRWjwPZsAefb5h
 hHOSrGbJJAgpMxBsZmXuTxrLVp26Wg1LTSZ5nyLwLikhs3oG+XzZjz79kgfTct9VAH+W
 wnap23BkNHz2wCXD2qA/jUDAY825EYkkDQ95DBVa973+qGV2v1sfX8J+QmLYb4+Lzh8D
 lPcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788783946; x=1789388746;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=DinF6L5tCO8w9xnhTeC9FoEWwHFbbcbvfZ4yWVeupOk=;
 b=QmB30doS0Pq1MZ9e8o8H/cicDwkh0YNJ2cCl2OAzDjcaYYgLI2Ajun6kdgh+jFesDD
 IXVcNNfiYSMUuaWq6T2KpcgeAdN3BSjis8Nbynk+FJSlQcCmmwG7C5+oezLHLdX96Uzq
 okuG/taOzAif+RtXUJ573IY8U3HFKxWR777qqEeKVo5b5XesRTWH04UQP86CnxHqSXNK
 oGzvH8MKPBqXJJ8L0LXoF+LKOWAZ2yeqT3Ogy4bhVnEe0iHCb0T+zryDZ2oD8uDFBFoE
 5de4jPLCrEl5C3aXt5z1zHjh7egzYGXDTEn7OUKlQ3qwriYO3d7pxK9UgEFY/Wi3K1EC
 rUtg==
X-Gm-Message-State: AFuF++lGkoGgYnR7vWCrmX/DeSIFZ/NQpJVmjDqwVseTWjscRp2aXsky
 4+lnN2NOmvmuUu4vzWhNJGEGVDIa7rb2HVBRbGq4BVdz6tQKGGUTnvelucy3kL8PdHjTNYQxF+f
 2zYPFHZMMkQQKIVT/r5pts3m75NHjONlW6rW0wM9TDg==
X-Gm-Gg: AYBFou08mr8HJQ3rKnnUyTHE+INBEgq5EuduazrpZkjAfUWZgWdNWL+SxwTBTn1Is4h
 +qBg9QGdPh3+H8pWJAPbNknWrPQWuuxRlCf/B7GNBpym/pHiPkUhx/5oTorAvN91HxNQlLT8od9
 pCwUeceGpBGgegNCncN2k8keRED4QrT+JWb09BxBWRUjAOQVkeXQe1gelc30x7J/DwatD/cU7o4
 qrOTIds/twa/iW4u/xiXV05i9uv7HfimKKXAG+TSDrtl8eCPOoiRBALJMd8GZhrfPyhT5qKSZiW
 dmOVoX0G8bd+lnkjsZS/RqellHqVLuVYxuWx3nim3BT/F24pyroCPmo1FWNXMWVvLpwdC5O0sNi
 pw0OnGsgEmC02TO57kBIUDnOU1E3noWXQOF+70GUpTUNTQnsVgGTwZO44MKHia9/LAFaOgnHa3C
 T5VTEqCAhxM6n5tUu4ZHkVloXED5iD7nZulrXL70vaZRqB5D5VWwB+o1cUHktAOMqIpV3XbISWq
 qmSwZzMGFyQ3The/0KcxO76VTnqRS9wkHSFxyZ0wOJIs+Gl5xilBzg3QTVw74H9zTd0WCjxItxf
 yVLomQYkqrs0/KvOKiwDu9zK0LzFSQB5dxd8HBwwCRduyZeC/U8Kjqb4ILinRfsgM8307Tr9eRs
 +cgIESDVCEAVC5UUwR2VSORrDn6LlC/YiypC8I0Ybayo=
X-Received: by 2002:a05:690c:670b:b0:816:b469:ccfd with SMTP id
 00721157ae682-8712727669emr96704057b3.15.1788783946220; Mon, 07 Sep 2026
 05:25:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260904-dead-v1-1-2ecf6ffe7bac@arm.com>
In-Reply-To: <20260904-dead-v1-1-2ecf6ffe7bac@arm.com>
From: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Date: Mon, 7 Sep 2026 15:25:09 +0300
X-Gm-Features: AcwNN1Xa871TBVcAT_2kouqF8W6SY6l-r-CUmYZfdioyfbLHLIKm22INLVxTZvY
Message-ID: <CAC_iWjJRn5sYn+MLz=5+s0cBqfYUprfA_BtGBhnDbNYLmGUM3Q@mail.gmail.com>
Subject: Re: [PATCH] efi_loader: remove unused function efi_dp_match()
To: =?UTF-8?Q?Vincent_Stehl=C3=A9?= <vincent.stehle@arm.com>
Cc: u-boot@lists.u-boot-project.org, Heinrich Schuchardt <xypron.glpk@gmx.de>, 
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>
Content-Type: multipart/alternative; boundary="000000000000b1daef065ae3b7a9"
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

--000000000000b1daef065ae3b7a9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 4 Sept 2026 at 18:58, Vincent Stehl=C3=A9 <vincent.stehle@arm.com> =
wrote:

> The efi_dp_match() function is unused since commit c409593d0853
> ("efi_loader: fix efi_dp_find_obj()"); remove it.
>
> Signed-off-by: Vincent Stehl=C3=A9 <vincent.stehle@arm.com>
> Cc: Heinrich Schuchardt <xypron.glpk@gmx.de>
> Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> ---
>

Reviewed-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>


>  include/efi_device_path.h        | 19 -------------------
>  lib/efi_loader/efi_device_path.c | 22 ----------------------
>  2 files changed, 41 deletions(-)
>
> diff --git a/include/efi_device_path.h b/include/efi_device_path.h
> index aae85228f68..034a476887e 100644
> --- a/include/efi_device_path.h
> +++ b/include/efi_device_path.h
> @@ -33,25 +33,6 @@ extern const struct efi_device_path EFI_DP_END;
>   */
>  struct efi_device_path *efi_dp_next(const struct efi_device_path *dp);
>
> -/**
> - * efi_dp_match() - Compare two device-paths
> - *
> - * Compare two device paths node by node. The comparison stops when an E=
nd
> - * node is reached in the shorter of the two paths. This is useful, for
> example,
> - * to compare a device-path representing a device with one representing =
a
> file
> - * on that device, or a device with a parent device.
> - *
> - * @a: Pointer to the first device path.
> - * @b: Pointer to the second device path.
> - * Return: An integer less than, equal to, or greater than zero if the
> first
> - * differing node in 'a' is found, respectively, to be less than,
> - * to match, or be greater than the corresponding node in 'b'. Returns 0
> - * if they match up to the end of the shorter path. Compares length firs=
t,
> - * then content.
> - */
> -int efi_dp_match(const struct efi_device_path *a,
> -                const struct efi_device_path *b);
> -
>  /**
>   * efi_dp_shorten() - shorten device-path
>   *
> diff --git a/lib/efi_loader/efi_device_path.c
> b/lib/efi_loader/efi_device_path.c
> index 9efb158f5dd..0389af23906 100644
> --- a/lib/efi_loader/efi_device_path.c
> +++ b/lib/efi_loader/efi_device_path.c
> @@ -60,28 +60,6 @@ struct efi_device_path *efi_dp_next(const struct
> efi_device_path *dp)
>         return (struct efi_device_path *)dp;
>  }
>
> -int efi_dp_match(const struct efi_device_path *a,
> -                const struct efi_device_path *b)
> -{
> -       while (1) {
> -               int ret;
> -
> -               ret =3D memcmp(&a->length, &b->length, sizeof(a->length))=
;
> -               if (ret)
> -                       return ret;
> -
> -               ret =3D memcmp(a, b, a->length);
> -               if (ret)
> -                       return ret;
> -
> -               a =3D efi_dp_next(a);
> -               b =3D efi_dp_next(b);
> -
> -               if (!a || !b)
> -                       return 0;
> -       }
> -}
> -
>  struct efi_device_path *efi_dp_shorten(struct efi_device_path *dp)
>  {
>         while (dp) {
>
> ---
> base-commit: cc557af4553382f6f50e3ed62b9577054e7bc54f
> change-id: 20260904-dead-190dd2512e4b
>
> Best regards,
> --
> Vincent.
>
>

--000000000000b1daef065ae3b7a9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:arial,sans-serif"><br></div></div><br><div class=3D"gmail_quote gm=
ail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, 4 Sept 2=
026 at 18:58, Vincent Stehl=C3=A9 &lt;<a href=3D"mailto:vincent.stehle@arm.=
com">vincent.stehle@arm.com</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">The efi_dp_match() function is unused since comm=
it c409593d0853<br>
(&quot;efi_loader: fix efi_dp_find_obj()&quot;); remove it.<br>
<br>
Signed-off-by: Vincent Stehl=C3=A9 &lt;<a href=3D"mailto:vincent.stehle@arm=
.com" target=3D"_blank">vincent.stehle@arm.com</a>&gt;<br>
Cc: Heinrich Schuchardt &lt;<a href=3D"mailto:xypron.glpk@gmx.de" target=3D=
"_blank">xypron.glpk@gmx.de</a>&gt;<br>
Cc: Ilias Apalodimas &lt;<a href=3D"mailto:ilias.apalodimas@linaro.org" tar=
get=3D"_blank">ilias.apalodimas@linaro.org</a>&gt;<br>
Cc: Tom Rini &lt;<a href=3D"mailto:trini@konsulko.com" target=3D"_blank">tr=
ini@konsulko.com</a>&gt;<br>
---<br></blockquote><div><br></div>Reviewed-by: Ilias Apalodimas &lt;<a hre=
f=3D"mailto:ilias.apalodimas@linaro.org">ilias.apalodimas@linaro.org</a>&gt=
;<br><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px=
 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0include/efi_device_path.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 | 19 -----------=
--------<br>
=C2=A0lib/efi_loader/efi_device_path.c | 22 ----------------------<br>
=C2=A02 files changed, 41 deletions(-)<br>
<br>
diff --git a/include/efi_device_path.h b/include/efi_device_path.h<br>
index aae85228f68..034a476887e 100644<br>
--- a/include/efi_device_path.h<br>
+++ b/include/efi_device_path.h<br>
@@ -33,25 +33,6 @@ extern const struct efi_device_path EFI_DP_END;<br>
=C2=A0 */<br>
=C2=A0struct efi_device_path *efi_dp_next(const struct efi_device_path *dp)=
;<br>
<br>
-/**<br>
- * efi_dp_match() - Compare two device-paths<br>
- *<br>
- * Compare two device paths node by node. The comparison stops when an End=
<br>
- * node is reached in the shorter of the two paths. This is useful, for ex=
ample,<br>
- * to compare a device-path representing a device with one representing a =
file<br>
- * on that device, or a device with a parent device.<br>
- *<br>
- * @a: Pointer to the first device path.<br>
- * @b: Pointer to the second device path.<br>
- * Return: An integer less than, equal to, or greater than zero if the fir=
st<br>
- * differing node in &#39;a&#39; is found, respectively, to be less than,<=
br>
- * to match, or be greater than the corresponding node in &#39;b&#39;. Ret=
urns 0<br>
- * if they match up to the end of the shorter path. Compares length first,=
<br>
- * then content.<br>
- */<br>
-int efi_dp_match(const struct efi_device_path *a,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct efi_d=
evice_path *b);<br>
-<br>
=C2=A0/**<br>
=C2=A0 * efi_dp_shorten() - shorten device-path<br>
=C2=A0 *<br>
diff --git a/lib/efi_loader/efi_device_path.c b/lib/efi_loader/efi_device_p=
ath.c<br>
index 9efb158f5dd..0389af23906 100644<br>
--- a/lib/efi_loader/efi_device_path.c<br>
+++ b/lib/efi_loader/efi_device_path.c<br>
@@ -60,28 +60,6 @@ struct efi_device_path *efi_dp_next(const struct efi_dev=
ice_path *dp)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 return (struct efi_device_path *)dp;<br>
=C2=A0}<br>
<br>
-int efi_dp_match(const struct efi_device_path *a,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const struct efi_d=
evice_path *b)<br>
-{<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0while (1) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int ret;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D memcmp(&amp=
;a-&gt;length, &amp;b-&gt;length, sizeof(a-&gt;length));<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return ret;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ret =3D memcmp(a, b=
, a-&gt;length);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ret)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return ret;<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0a =3D efi_dp_next(a=
);<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0b =3D efi_dp_next(b=
);<br>
-<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!a || !b)<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0return 0;<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
-}<br>
-<br>
=C2=A0struct efi_device_path *efi_dp_shorten(struct efi_device_path *dp)<br=
>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 while (dp) {<br>
<br>
---<br>
base-commit: cc557af4553382f6f50e3ed62b9577054e7bc54f<br>
change-id: 20260904-dead-190dd2512e4b<br>
<br>
Best regards,<br>
--=C2=A0 <br>
Vincent.<br>
<br>
</blockquote></div></div>

--000000000000b1daef065ae3b7a9--
