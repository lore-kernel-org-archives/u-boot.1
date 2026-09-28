Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C57DCA5FA1
	for <u-boot@archiver.kernel.org>; Mon, 28 Sep 2026 17:08:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 030C980E84;
	Mon, 28 Sep 2026 17:08:46 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4oCOgE7YyFyh; Mon, 28 Sep 2026 17:08:45 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp1.osuosl.org 3ECEE80E31
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=3; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790615325;
	b=E1KtxzrxWcQ1QJvuHZtfY6idtne/IeiFHRwYuz8AXC+f8KwHu53AF1zgBKCV0hLp+EOr
	 KyzswH714xE0pOsJZzxrYyhEpm1QdDEi349zpWwsOAtuNyxdhFR5l9gO2XHPc0ZnfBctV
	 5NZi/INXWF+4c07qI3aHlOSd6k9Klay5t03vAaejLBsRF6yVUApeMsB0+nZW8+Oxz5gQs
	 p6tzl5wGPGBxgEABxZr0XCGvdYtxy7UXwZRryiNjueN0/8jEgT2yFDCqfPWRy+8odq96h
	 gBavGEKQjUiCSQxaZ7qR3NTvSrDSWtWywV4JHEc5uz+VNxWFiVtX+hlROUZLixG88Gw==
ARC-Message-Signature: i=3; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1790615325;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:MIME-Version:References:In-Reply-To:From:Date:
	 X-Gm-Features:Message-ID:Subject:To:Cc:Content-Type:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=E+sjBg4eOcTJYmBEEPNllYUckh1ov5pmCGKbRUeX48E=;
	b=YS0ebwKA4EQ3bmeR0qRhqkdwGxAAlneCVvTNvSuaIN7vfOLElo7XBdY1hh9LXpB6xH29
	 qUpUPjNDZFPaP/Ihk0Vp0R/dzjJBfJFBJBY1X20AixBI1KZ5EY6onyeuTj7XSVrFnhvKH
	 55ftGA/vh8qcaWkLAIOxQq9BKI+/8aCOmJip9Iu0ZUIFthMJHX7vvNOhw2cHfZYkVT0aZ
	 6P1KYB2XKSpD1ou2drs6Oqg1HPEQuu+MuDJVygkdx7CGA/YoqJsavgj38mgcehR0e56Va
	 h5BJTF8WbyT9PguNhFggblJQyx8bPxLCGfoFIlDZISwwICvghNS1v3tjkexdxCMi8rA==
ARC-Authentication-Results: i=3; smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1790615325;
	bh=E+sjBg4eOcTJYmBEEPNllYUckh1ov5pmCGKbRUeX48E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=cBM3gzAtizpA/IZDtQWolKJXmzYhyT04CtNvcd3bfvjK781BqL6SjOHoFn9w3InBp
	 KpLzqLNCgwQNCAJ4jbgcE/PgKog9/bQ+hgGpWFQ4pkEjGqF8SPg82VUhP/8EI7e8E7
	 A7Ygj0LHXt8uwIkUWphYuW1zJ3FjsYMcom7AinTaPcqmRm4FQ/lsQcgD9NyVOB99VW
	 CoJkleAJxN1A2D1IQpp+PaC2peA5sKWgbiW3zBIeNzYvMteqqG+2se1ajtCq4MbqGZ
	 1tSM9pce8c+j1vjLVm3qmWNFCrgIJBgUN2dzHbuh7YnRZpWZqqMEzX9A56cIEeUBQz
	 YnIaqTJZPIs6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3ECEE80E31;
	Mon, 28 Sep 2026 17:08:45 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id CF77672
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 17:08:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id B42134054F
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 17:08:43 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id O-TLgZntowqc for <u-boot@lists.u-boot-project.org>;
 Mon, 28 Sep 2026 17:08:43 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 97E4B4052B
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip="2a00:1450:4864:33::27"
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1790615323;
 b=BLEZ2FxhZvprhhoZYGS72tQRqTz/dmI9d3e7h+xeGDnmMl/3nwJuPqk79Lm3VtIeGsIq
 EF1Rw+rKb84FrOraQuCzFE42p7XqY/2rQJhwEHIAf/vrP+73Q10rAXLxO4fDteRklcmyW
 cLBrBj6tuYCiUmhEZEMewvqM1hoK8SRXeH86YtLDCnYtbOGnNQ1QXK2Pz+eXfmQeMMMd8
 oIEa4MXMolRGWAmcJj8CIf2nAZ/qr9nApwNp82wF9CiZBrThzTmR+N7wGZgKiSR/QtEkb
 i1MSakLnRcM9er4eW6pcMnjHJKsL5NcCAt4sB8sJwFj0cyieqahSZX1qL0179c9Rrlw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1790615323;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:MIME-Version:References:
 In-Reply-To:From:Date:X-Gm-Features:Message-ID:Subject:To:Cc:
 Content-Type;
 bh=E+sjBg4eOcTJYmBEEPNllYUckh1ov5pmCGKbRUeX48E=;
 b=dJJQO+OA86XoGMJusk/fM6xq7jPh4IjdGljqCPKNESnAGkS/xjuTvcwnkrfdr7E+0UtF
 Dd1Fctt3ZKMA9T0S+NJR5aotawH/i4CBscbhOVGpZgSbWxWl4CPX2uP4BInPNa4PFXPSl
 24qrvzfwgOvU4s38Or9dLZv0ZOnnU02964v35DoDBqNkzeeDEqkv6z7vyFZQF4FHwB3Jw
 I7VCBofxAM+d0TvQHvkDhxrlGWIcwzQFB4U6X1RGuZ6/XQXIEqGJ0ymUV0Zg/bOXyNj27
 Je1Z89jT8HoPZOXSmJ3ePhCLkFB1W2B2FLcJ0qo5w/1YhxAEpyu99sOZv9wsR5FLaIQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org;
 dmarc=pass header.from=chromium.org; 
 dkim=pass header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=nrGq61BZ; 
 arc=pass header.oldest-pass=0 smtp.remote-ip="2a00:1450:4864:33::27"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:33::27; helo=mail-ed2-x27.google.com;
 envelope-from=sjg@chromium.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=chromium.org header.i=@chromium.org header.a=rsa-sha256
 header.s=google header.b=nrGq61BZ
Received: from mail-ed2-x27.google.com (mail-ed2-x27.google.com
 [IPv6:2a00:1450:4864:33::27])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 97E4B4052B
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 17:08:42 +0000 (UTC)
Received: by mail-ed2-x27.google.com with SMTP id
 4fb4d7f45d1cf-6aa135d6e97so5168256a12.2
 for <u-boot@lists.u-boot-project.org>; Mon, 28 Sep 2026 10:08:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790615320; cv=none;
 d=google.com; s=arc-20260327;
 b=loZFgL2iAqpesIEzxqqy9oxgrfY/BpfXsHG01UgfghRQZ+9JYZS61pjGp0EhFgmJw4
 n69T8tuHMGDi1PofdIdH3YJLt7BKTsq5B8xeXQ+7E8KuCIruVw3fAGug4tC/Fxg2fdHI
 LthKfEw3bd/XMOa69Dz0XrBYamNZ7a4a65twuJKiDs44hNouX9Dp0JyRAB9FrlJYkjK4
 kIRj7QKuOKi6sGPS8bLLNJOZV5OlsudSCVKZ7cdw6PjncEjoaZRE67kzrk0hTL63k86z
 GQwES5S6AEmAdoVZTbbCXkkL6RiemyN/WR3+Po8wytpl4neIExZUcUTKXRCJXZvRlGum
 xWsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=E+sjBg4eOcTJYmBEEPNllYUckh1ov5pmCGKbRUeX48E=;
 fh=IAgKudDbKG9+2gjeBrcrgcf6XlrOZMsCHYryACa8tNY=;
 b=HMWlRLjjHLC1dKkPFrmhOwaFHd620oY7yjAIVwUIBVxSYz8UCZlTHG6xIrMAW790uL
 zFRW+UH24rjuB3Uqknagec8qsD66wPbr53ybSbQrmpVOU4NVMfD+vXfO9ww0XiaiCMB/
 gcUwOXcAwekPt8o3lIBQXkhA/YnQcTcmQ+rqLCNDv+I79zlTi3n6fYG+sBoIlB2K3ZZu
 mIpUfPaO10mPVu3xm8Ty5ilj1lDrMlL9s1PAReywPHEyz5mncQKN5GoeFwonnJp+NOyo
 VS//CS01xe8kdiE3oAXfZroNLP5kjHhjD8XOOQN9Y2qb02L8cwrd0Pxf3Q0nSX+AZrZT
 1xGg==; darn=lists.u-boot-project.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=chromium.org; s=google; t=1790615320; x=1791220120;
 darn=lists.u-boot-project.org; 
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=E+sjBg4eOcTJYmBEEPNllYUckh1ov5pmCGKbRUeX48E=;
 b=nrGq61BZ+a2rrcmgnR2gvsnIXayIGUAnISUjMJHS8oBJutuIOdbJJ9o7FjliJC0+zI
 YTadob+x+F6MRY5tsNMt1rW5v7Ym8AEZbb4GREOgyFDHHsWClYYTaWTYldIPLIaKhtvu
 Vjaz0+Vky6zti5eYUdku/FY8lQy4xBmAMTUlY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790615320; x=1791220120;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=E+sjBg4eOcTJYmBEEPNllYUckh1ov5pmCGKbRUeX48E=;
 b=c7/vEhDCeCYWT6EkVsjSqa8+MBgrbibcd8Mrzg/a5ZIYqU08ytbmuSDMOnhemn0I96
 RboGdSlv69Q2XbZUJOHgyhoj+E5UI1x8wmJupicQ50XmXSoe7pWKNlwxxu6f68/7wDrl
 q6Sicrc79HMJxSRvQD8FSE1M0vFCC3LQ1xqpj5mvtngLcgLUnhlwUPv6CjIfd5+weSik
 1ATAmg/34NC41Rr+j+MXiiRHydrPPPjHhf4YJSaYDLQcKMGMjA92EyV9/nje/PKdFRTs
 PmIMEYWS5+bHsgprwirWfaeS3atu6H9lgoQxbdmbAL7xu8wQTJReZJ8HFpKCa/DekYv3
 aCkQ==
X-Gm-Message-State: AFq9FYLxuIqRlBZjXBkABwgXTzzgta0YzJwBWn5N/uDujXLpLhzviAWZ
 9kmbwXzSIMrjrRMvmFSu37QXsSNuGSi5N60H8Zr2LRm9F39ZZp6o7voiQzdlAhht2Aibji8eU2c
 DaHsmUyOShHbc91+Z7j0QkKX8P00c9z4qkiKz7YNTbEth/y9br74=
X-Gm-Gg: AYBFou1JNI02fruEOeXcvP99nWyeSYFVoBlMsGsyvdVfIlVvKjr9N9D9UAjmTGtFrvT
 uiWr8xc/p6jHmODnYaUDBgEXdX2OFEpjw/2Nus9M6fgcJm1UR2ecI1UiRkPnylT9KjVctI/C5Jm
 j+ZbjHY09i6GNv9pwTerIbYZKRtf8xVzvA0kirwZ//nYWrQ4TlULixLJ9isEPgwqVlG91/Cc1jR
 o1CoLkcJ+oRZp26gIGSqbwKyW1fdmROt6KB3nTn+XXMiBUoievzGiIm8+chQYOOLB2bsuxwxoeX
 pPGnOz2IEC12qZv79uQMa7H0VNT1IFLtiJaLTJAxE+cXoF3UNxWnnw==
X-Received: by 2002:a05:6402:20cd:b0:6ac:8dba:e358 with SMTP id
 4fb4d7f45d1cf-6ac8dbaea9bmr1616558a12.5.1790615320245; Mon, 28 Sep 2026
 10:08:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260922051838.526368-1-hs@nabladev.com>
In-Reply-To: <20260922051838.526368-1-hs@nabladev.com>
From: Simon Glass <sjg@chromium.org>
Date: Mon, 28 Sep 2026 11:08:28 -0600
X-Gm-Features: AclHuK8IPdXKpHMxjPCW4LfTBDQMNcDnAViJZ3DKeDaU-AaOwCr6iTgu-J1AG24
Message-ID: <CAFLszTgXp8JWtSmR1h3FQzZdcxjJBBA3P8r1wB-bW5mMox64fA@mail.gmail.com>
Subject: Re: [PATCH v1] binman: nxp_imx8mcst: allow selecting the SRK table
 index
To: hs@nabladev.com
Cc: U-Boot Mailing List <u-boot@lists.u-boot-project.org>,
 Marek Vasut <marex@nabladev.com>, 
 Simon Glass <sjg@chromium.org>, Stefano Babic <sbabic@nabladev.com>, 
 "NXP i . MX U-Boot Team" <uboot-imx@nxp.com>,
 Fabio Estevam <festevam@gmail.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>,
 Stefan Bigler <stefan.bigler@securiton.ch>, 
 Aristo Chen <aristo.chen@canonical.com>,
 James Hilliard <james.hilliard1@gmail.com>, Tom Rini <trini@konsulko.com>
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

On 2026-09-22T05:18:35, Heiko Schocher <hs@nabladev.com> wrote:
> binman: nxp_imx8mcst: allow selecting the SRK table index
>
> The SRK table installed by HAB holds up to four keys, and the CSF
> "Install SRK" section picks one of them via "Source index".
>
> The configuration template hard codes index 0, so an image that has to be
> verified against any other key of the table cannot be generated. That is
> the normal situation once a key has been revoked and the next one of the
> table is put to use.
>
> So make the index configurable the same way as the other properties of
> this etype. Add an "nxp,srk-index" device tree property, overridable by
> the SRK_INDEX environment variable, defaulting to the previous value 0.
>
> Signed-off-by: Stefan Bigler <stefan.bigler@securiton.ch>
> Signed-off-by: Heiko Schocher <hs@nabladev.com>
>
> doc/imx/habv4/guides/mx8m_spl_secure_boot.txt      |  2 ++
>  tools/binman/etype/nxp_imx8mcst.py                 |  4 ++++
>  tools/binman/ftest.py                              | 20 ++++++++++++++++
>  .../binman/test/vendor/nxp_imx8_csf_srk_index.dts  | 27 ++++++++++++++++++++++
>  4 files changed, 53 insertions(+)

Reviewed-by: Simon Glass <sjg@chromium.org>
