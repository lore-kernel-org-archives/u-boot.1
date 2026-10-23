Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42632606A329
	for <u-boot@archiver.kernel.org>; Fri, 23 Oct 2026 11:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=i7ofLfG4;
	dkim=pass (1024-bit key, unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256 header.s=google header.b=PEXk7sDX
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1C984812CD;
	Fri, 23 Oct 2026 11:05:52 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 46XctXqFBvz7; Fri, 23 Oct 2026 11:05:51 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 152ED8121F
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792753551;
	b=gztQXCKC/fAlvzIduzP9Dp7CS946n3VdfbdyoF3aYhq/MaAyF9Kv9yOobnhTN4lM42da
	 auIeGuMSAaUrlj0X/uMHV3FwUrnKHONgvoYtmTEoNj1ynoH+PjeECmDaekxH7TPl5lA50
	 PEZxOQRL7yZlwVKHQD+IcXGbcGWGMGxYlJWlzOu3uNVDSbKVMWtVLQg6p/tkd6LSssUwr
	 x+Dt0ayDVmNsCfKkY5vNiEE9jJ2IXj+cMftaOyA3BrGx6yI5cskDkWXq6T54dOioJg8b1
	 TnPsrO5qPQIQIxos+GVS3E34agvR3ZK5xh/xTXsTRAIpYf/JzH5hdjOeY3f1zUIezsQ==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792753551;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:Received:MIME-Version:
	 In-Reply-To:References:From:Date:X-Gm-Features:Message-ID:Subject:To:
	 Cc:Content-Type:X-BeenThere:X-Mailman-Version:Precedence:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Errors-To;
	bh=EkcAUlFnsY35b3JNMHOtdY/WBRsyOoS9z9/hn0W9Dt0=;
	b=Tv8mqEy90fRB63STthwNbki42eJvp8KriX6Q59OG8NMDBLT9iPQsgZNNn1nuyLF+bpd0
	 U/1OCjssiVc66HSwMQB94rS/r+VhG1ThyrOwIcTW6hEVqEqBB28+6xu3YOo1TYdBJTJJ/
	 BXBkVTIn0oPdetn2Kx1YQN5deMnjFwA+WYrDB/454iqAgdaKNosbY/EhKXqgk+ZhtTcHL
	 343BldnBbY/fsTIVwt4SURvw4lgMprmgTrXuvokx4IMwCb0VrbR+mBY1Z8PI8qDdK+X6S
	 fK8Y0g/oCycd/yEwTrpUO1ynrSv4hsu4KpP99Z2XvGURiG9rMWr/rsqBz5/0TkV8erQ==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792753551;
	bh=EkcAUlFnsY35b3JNMHOtdY/WBRsyOoS9z9/hn0W9Dt0=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i7ofLfG4quAfXY+6GGH8fSeJx+3HEmM8MU2/2eGSeWitVH3Ad4hgzaqw9aSgok37I
	 Ew9/kyS2/YDTKoZ6EQvbgLsiwcXqPQ2kBOWgLbtIlSAcuR+Bc1efG5aeu/aMIb597z
	 wNZk74jhnjJMzrxY8vQarQbZYxRdjdZhQzZzKrNz57hs9CADvQSMHpXeMhonIV4j6V
	 Smv1ps//mYV5Ihq+V75l0150fv+Hc/YO+FXOetQzSH1kFxuCWuLZJUX7a453B3QIYL
	 AKZlDaVT9YQAZZvITq9/nyis1y99pzKcBkhPJGairK50sdg0Tu5G1emoGD8SYdqsnn
	 O8EFPbRGjte+w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 152ED8121F;
	Fri, 23 Oct 2026 11:05:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id DD8CC3C1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:05:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CF18740911
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:05:49 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id mbTW4AbYHf7z for <u-boot@lists.u-boot-project.org>;
 Fri, 23 Oct 2026 11:05:49 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org D7D3140904
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:20::529"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792753549;
 b=el00TLjdGqR3GbIef1VEaVtuK4yhNisL4q001/ojhvkMXwylc7uUcqUMCn2IXJJpqUPk
 p4OyFjlNtgFp5g7nFN51IMf22XBqJti8OezfVDsq3ZbQpfFogY1cG+ER0yJCtF1KqDvQX
 NbBM+7w2EmziAX9LYUYzVs434psXbE2PGaovTxl6VIoQR4kW/+k3DpJ0fXYposvYFBoY/
 2DsBJzczoeTv51UVOxqSCT3GI+71NoWsUSCRb0qihcfkY0cuCymlWC/BFLMuJNXcMAZ+w
 bB9jMltP0b4mxvA2Sfw9CA07VHv28YoRpTH+eeqJaNc2RnhKH8k0a2WBT4bqVTBlb3w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792753549;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
 Received:MIME-Version:In-Reply-To:References:From:Date:X-Gm-Features:
 Message-ID:Subject:To:Cc:Content-Type;
 bh=EkcAUlFnsY35b3JNMHOtdY/WBRsyOoS9z9/hn0W9Dt0=;
 b=kw0vCikOLACyEuobGlHA1Rg3m6ZVGUFGZBJrC4dLVUYZtzpTpZ5utuVQE9ofK35/RUTA
 ZIi5dmFmSDQwG9Q8Q2w9LON79dXIwQ5fWF2rJyfli8wILrmkRzFucP/nWz5wPcQBEbp1t
 hig3CRg0W7iZ21Mczh1hrpTpaWWo+LIL7Dr/3NDrN/jFLFRheJkbXfCSaWChKQ7MWVLFD
 YlwaTkFo0IESgFVj4gDZue8RzSTEjD8FvbxsDbXoFCCF6AtYEru7Y/g4JknQI8CUvMS4N
 Ko8pw3BAZlfrs8WITZgIeSrSKjEeMOxmXE3xOZ+LlPi8eQGp0j7oWLAxf/W3BSZlB8w==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; 
 dmarc=pass header.from=chromium.org;
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=PEXk7sDX; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:20::529"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::529; helo=mail-ed1-x529.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org
 header.a=rsa-sha256 header.s=google header.b=PEXk7sDX
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com
 [IPv6:2a00:1450:4864:20::529])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D7D3140904
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 11:05:48 +0000 (UTC)
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-6b167ffd132so1134861a12.1
 for <u-boot@lists.u-boot-project.org>; Fri, 23 Oct 2026 04:05:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792753546; cv=none;
 d=google.com; s=arc-20260327;
 b=Z11WRvug4CuLlbv+6AC9EoJGwKMJ64c2+DgftgDQE0f4gCE2PhXMw+UxW+Ey1EWu4Q
 xjOOa7znagAe32EJnFU7xlUj/Kfni8b2cq0lRTyYO1K2yA3vUmAsZVe2fmZqxGtwh1ec
 BWjE9UUWyo8aXZl5dZGaaGpt4syZaL3EWijn7iz+JiGYEMqg4tym7kW9cRRNxzEnAjUD
 3qHlVSTr3yfm/LkLTsGekn465hFcUFIKmSx21CeEZqeqD4cQg+g0phuRRoLNHOpw29nf
 ujgmmq+qh1BmaMAcEDcRdvHmHd2fR3Wj1PT53h8O7a0LIBJl/5x1BFeJrQBhq4GgTxNO
 8VbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:references:in-reply-to
 :mime-version:dkim-signature;
 bh=EkcAUlFnsY35b3JNMHOtdY/WBRsyOoS9z9/hn0W9Dt0=;
 fh=dDIBRx/qeHG3hiMnQ1O9IW2V/VzQgbZdPDMmHeMUdrs=;
 b=hpcIM6H1oyxkFzbOPiU8tmYcaZWFszdJyeouIL13CLQ2ILVATGnwdfwZEAeyXO8UF1
 iSTm8MF41FNc1bGE1OYnql6NqbdQcWXA9cmEITjnY6Iclee+GzEEJYFFfp6nsVTd3U1f
 gALwZ4Zxi5XFzGJeKNAmREdSVrC5ZdyaFv1GfZfoouMNHNHmdqyxSU66gci48iSLbfN/
 1GpueXam6ruG//EvdqCsm4zVfsnjvS+yBoCuKYmRC/3Y+DO8aZsqZ57Gzztv6gfiYfwe
 0bv9gf+iSIKYdaftWuXUsbLMiw+XBDQVB8YMwIG2yNY02SbYrunyaxKyMsxoVkL+BSwg
 XLcg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1792753546; x=1793358346;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=EkcAUlFnsY35b3JNMHOtdY/WBRsyOoS9z9/hn0W9Dt0=;
 b=PEXk7sDX4VAlkcjKJhig9i83uzXjxNTjOVDnBcQOh+CxLXZwOzLixfucAothA8a4LC
 zej6zlOrIP12l7ue90h946hnNiHywy8I4a5/uA8Jbc57yHc6I2gO0fAij6TuE/jpMsEv
 hffrHNQp3cpKJFM/c2UsvQmkuGTeD++FG6nVU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792753546; x=1793358346;
 h=content-type:cc:to:subject:message-id:date:from:references
 :in-reply-to:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=EkcAUlFnsY35b3JNMHOtdY/WBRsyOoS9z9/hn0W9Dt0=;
 b=DkpyL5HWkwcsV08KnoNXRWFy79FjLDrQuYby+onrYw9wNDvQLJxnknj2+KmpFqleXx
 RwUSUqU/QWTOKXZAqwkvYkUJ6z3T2oo3AAt85oycNGyjDwsI8a69Q2tRyJ2yCgyrjZG1
 hZAhwhjCllUnox4+V92+Cp/fTuxDwdpvdgDuxhmobtr24oTmPy+F7RjGkRsg6wIgZqLm
 Ryi5/7H6lxLWIvdMG3hecvu1TZzYxuQFvf9WHVBaa58fllT7D2VS5/k5ayPYdoEvTKhp
 iCYbl0siGWRX6u6A/tUo+z8VL0t2EYGfu+MS6jGmtZuQRzvZwEgMohwY8oTYB0FrXWM2
 ePAg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzpZ2bYWwsfyFkLATGfHzhf5+rc+pgu19nCj9CI2LQUiBvpYY6dqr0ADcm46+e0QTGic4N3dcs=@lists.u-boot-project.org
X-Gm-Message-State: AFq9FYKRrNlhOgmtxp5wmNZ9ffxncIhxBzMlvJoeBBY9WMRrdvRYMUKy
 VswgZke7IpX6akf1HrayS7iBbDqL8vSSkjcBzfRiTwL8PtZVvuSqQLJ4j/bar9pxmfp9iZ61eYm
 CVZEPLmlojzQ9FYlBPxzc+suYz63BDHmVzS3s9H6c
X-Gm-Gg: AYBFou01i++/XvXo7pRa7+Oh2KqoUNZH8aXJrk8plBrmyUG7Pfpjm6Ly4cbyFt+XE3/
 sqFniEyAM+/RZGQl7VBxpBEcdLcJFMMLy7JJmgkUXK3SN6l2QESF9d2O7n6aPaRmwUsC8popvMN
 rDQrT7BQdC5TYQgd4KVnavY4fwCDkTU/KzshmqVrGchgL8DE2SMItAytWYyRk/qRkn+I8W/VlGB
 lFlefdNUu2jMVeApoLfIs/hTuyCJ9Kyx3auC7zKEaUJR8/SIv4CtInMlfVj/VPyEyea4AOj+E+c
 RKKLR7q/VXHTl81nmrII0Qh6wrxFHmFfBDJNZmORoGqQYDx5GY5TPYxmllUkSgiIisH18YDIIj0
 WFAprTFiNJDdHiPGntzqlA33oZ6sXLHZ7vaM=
X-Received: by 2002:aa7:c84c:0:b0:6b4:16fb:b9ba with SMTP id
 4fb4d7f45d1cf-6b432bedbd6mr2140843a12.36.1792753545845; Fri, 23 Oct 2026
 04:05:45 -0700 (PDT)
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 11:05:42 +0000
Received: from 415065739583 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 23 Oct 2026 03:34:55 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20261022-test-avb-fixes-v3-9-d3a6ff9ba097@kernel.org>
References: <20261022-test-avb-fixes-v3-0-d3a6ff9ba097@kernel.org>
 <20261022-test-avb-fixes-v3-9-d3a6ff9ba097@kernel.org>
From: Simon Glass <sjg@chromium.org>
Date: Fri, 23 Oct 2026 11:05:42 +0000
X-Gm-Features: AclHuK-8uu-1uLmSCSIVT_WPl2pAyz14U5ua8T43FhGzA7FW2_KgsTOe9BOQcJ0
Message-ID: <CAFLszTgsBJ4BH8DE7hd_Y5sJtt4n0vGfXHckv8V+1tJ7ZM_PEQ@mail.gmail.com>
Subject: Re: [PATCH v3 09/10] test/py: avb: Add sandbox AVB testing with
 dedicated mmc12 device
To: mkorpershoek@kernel.org
Cc: Igor Opaniuk <igor.opaniuk@gmail.com>, u-boot@lists.u-boot-project.org, 
 Jan Kehren <jan.kehren@emteria.com>, Guillaume La Roque <glaroque@baylibre.com>,
 Tom Rini <trini@konsulko.com>, Simon Glass <sjg@chromium.org>, 
 Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 2026-10-22T13:30:29, Mattijs Korpershoek <mkorpershoek@kernel.org> wrote:
> test/py: avb: Add sandbox AVB testing with dedicated mmc12 device
>
> Right now, sandbox runs the AVB tests using mmc1.img, which contains a
> fedora image.
> This does not really make sense. We should test on an mmc device which
> has a proper vbmeta partition instead.
>
> Add a new mmc12 in sandbox which contains all required partitions for
> proper AVB testing.
> Use the mmc12 device in the avb tests only when running in sandbox.
> The mmc12 DT node gets enabled by the avb_device_id fixture if CMD_BIND
> is available.
>
> Note: the vbmeta.img has been generated using:
>
>     $ ./avbtool.py add_hash_footer \
>                    --image boot.img \
>                    --partition_name boot \
>                    --partition_size 4194304
>
>     $ ./avbtool.py make_vbmeta_image \
>                    --key test/data/testkey_rsa4096.pem \
>                    --algorithm SHA256_RSA4096 \
>                    --include_descriptors_from_image boot.img \
>                    --padding_size 4096 --flags 1 \
>                    --output vbmeta.img
>
>      $ gzip -9 vbmeta.img
>      $ xxd -p vbmeta.img.gz > vbmeta.img.gz.hex
>
> Reviewed-by: Guillaume La Roque <glaroque@baylibre.com>
> Tested-by: Guillaume La Roque <glaroque@baylibre.com>
> Tested-by: Igor Opaniuk <igor.opaniuk@oss.qualcomm.com>
> Signed-off-by: Mattijs Korpershoek <mkorpershoek@kernel.org>
>
>  arch/sandbox/dts/test.dts                   |  8 +++
>  test/py/tests/test_android/android_image.py | 15 ++++++
>  test/py/tests/test_android/test_abootimg.py | 77 +++++++++++++++++++++++++++++
>  test/py/tests/test_android/test_avb.py      | 31 +++++++++++-
>  4 files changed, 130 insertions(+), 1 deletion(-)

Reviewed-by: Simon Glass <sjg@chromium.org>
