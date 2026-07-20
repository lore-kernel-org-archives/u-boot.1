Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFD73C4452A
	for <u-boot@archiver.kernel.org>; Mon, 20 Jul 2026 13:28:07 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F36F2838D7;
	Mon, 20 Jul 2026 15:28:05 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="wGDBPBkm";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id DA875844F6; Mon, 20 Jul 2026 15:28:04 +0200 (CEST)
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 7BD3780517
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 15:28:02 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=casey.connolly@linaro.org
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-49553515a8bso20521535e9.1
 for <u-boot@lists.denx.de>; Mon, 20 Jul 2026 06:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784554081; x=1785158881; darn=lists.denx.de;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=RvHc8MItVSF3m7A8gsUK8HEgEe+ICE/Wo9CAMe9sH24=;
 b=wGDBPBkmE09j2DhDbHJVCzFQsmqazfT8V+n7iisf7F/NALRvTy+iHp5cLkPLyWfMKU
 ZCTTdUx63i7cFIh6SEErOWtDpqIi0V1CiXk2yZ3voZPIcbp/9iZijwKIYNFGBA0we+IS
 fox+9Llqd68JH7iE5JjZ0rGWecB5BwV3ZWwTkyDb4T2ye2zW2Msjku3SZnF5YzRH2ukn
 v0OhQIsISeLwJL1IRY0dQsq7+UhWL8XADvcEg4DBuoM1Wh6504AgdBrxjH3uoBv8lEAi
 XBJy5LBUTzehmSXKmjI8DURopL5cbcqZteo1o6LQPccGQpLADtLL+u2070CKnkf++Nqr
 Aayg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784554081; x=1785158881;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=RvHc8MItVSF3m7A8gsUK8HEgEe+ICE/Wo9CAMe9sH24=;
 b=HNHgyxMY5n1FNEmfd40bhOUBHGKYimH91C2IHatPNVhUcjOhVWM0rWNuGmGnAMCxI7
 hZYVKkCHVIeDAuCoyEkF2Gx1/4PYnSSe+JlQdOtBWKb5i7XTa1yHlpsGf5l5WJP85/vB
 LTnW0w4uPvGw588mR7yZGFVu6vELf2VPiu2SXupfjr7WKw/0KamKoZxog2hMm45XU8DW
 ELlQigiyGsENy3oKNo/Ff9EDkAQx8wgydop8DuD83jfktHbOcuNbjp9ziEf7H/Sqt6fo
 EH6dmDsvOyU/+J8WVS2sfLEC+Of8zzDMhCT/XmrERRuSEP6ICys22+2gEI+jk7hZWLvj
 gTtQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoTljItUguNrKIMUuovQZyLsc3U2wYEzHYbHSQypyjauC6qHqCH9uECsEWX/CqyNnoc8R+fXJY=@lists.denx.de
X-Gm-Message-State: AOJu0Yw2iWGJUBdT2h5LSPFLjYz75uyKh/+LqSesGsQ+//5vCwHcg3Tr
 stXP8YohGociSeEQzrNiWe88khb4Cz6ZJo6JnXJT1bRWOpamtxnEYb0JFTgPfh8IuheltjWlZCQ
 u92H8jtI=
X-Gm-Gg: AfdE7cnpc6adM9hGloNmLdzM5rqHzC1XGBN0Og81uzK2MM5L12SShszvHWkEZ6sxMKY
 +HDFYiy+YjSZBffqj5DzlkmFmJlM+zrbl3Jg1cQ2husxuBluzxisa9n5nvU7aNbggF5GxVxbURg
 Pg09qJjup2cgw0SmYaT0Riq3bXdK6sTZowkex+srXm4nr+BT1m6/oqOmYiaVyJlzIOurnwjZVjs
 lPjnJsk6F/0WugRkX2DkgxihwpzuYOulWH4XLoqd+V18QlSg7zhjBwDWnkHhJTq+bzgYyTu6Z/1
 k9g73ZHdkYjUS5Vf36jgIMgscKeru7yioilMmUKMEFyovTb/cBbYoAgel3iYhW7W8x1Zy+I/AQC
 Ozb4ya+QMPEhGwnZKXydOfmf9pnyOgAN4KLD/tTKmXD5Bm+/Wem2z5tP/Gm7lk99+4GC2VGk5TT
 UIKd82OLxMWPh6M4bU14g6bMiKSERbkffNBTMPddTXvj1oPvp0VCpRYARKfio=
X-Received: by 2002:a05:600c:4f54:b0:495:4815:2c54 with SMTP id
 5b1f17b1804b1-4954a41303amr158488835e9.34.1784554081398; 
 Mon, 20 Jul 2026 06:28:01 -0700 (PDT)
Received: from ?IPV6:2a0a:ef40:1d11:1101:a3b4:4010:a727:b812?
 ([2a0a:ef40:1d11:1101:a3b4:4010:a727:b812])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49564011868sm12554085e9.3.2026.07.20.06.28.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 06:28:00 -0700 (PDT)
Message-ID: <f234b113-2e18-429d-b77d-12a7e59be2da@linaro.org>
Date: Mon, 20 Jul 2026 14:27:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tools: qcom: mkmbn: Add support to create multi-elf
To: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>,
 Sumit Garg <sumit.garg@kernel.org>, u-boot-qcom@groups.io,
 u-boot@lists.denx.de
Cc: Neil Armstrong <neil.armstrong@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20260714-ipq5210-v1-0-0b98251aabbd@oss.qualcomm.com>
 <20260714-ipq5210-v1-3-0b98251aabbd@oss.qualcomm.com>
Content-Language: en-US, en-GB
From: Casey Connolly <casey.connolly@linaro.org>
In-Reply-To: <20260714-ipq5210-v1-3-0b98251aabbd@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.denx.de
X-Mailman-Version: 2.1.39
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.denx.de>
List-Unsubscribe: <https://lists.denx.de/options/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=unsubscribe>
List-Archive: <https://lists.denx.de/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.denx.de>
List-Help: <mailto:u-boot-request@lists.denx.de?subject=help>
List-Subscribe: <https://lists.denx.de/listinfo/u-boot>,
 <mailto:u-boot-request@lists.denx.de?subject=subscribe>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean



On 7/14/26 10:52, Varadarajan Narayanan wrote:
> Add a command line argument to take a list of files to be combined to create a
> multi-elf expected by the boot rom.
> 
> Signed-off-by: Varadarajan Narayanan <varadarajan.narayanan@oss.qualcomm.com>
> ---
>   tools/qcom/mkmbn/mkmbn.py | 15 +++++++++++++++
>   1 file changed, 15 insertions(+)
> 
> diff --git a/tools/qcom/mkmbn/mkmbn.py b/tools/qcom/mkmbn/mkmbn.py
> index 46edbcafb32..a2df1433129 100755
> --- a/tools/qcom/mkmbn/mkmbn.py
> +++ b/tools/qcom/mkmbn/mkmbn.py
> @@ -104,6 +104,9 @@ parser.register("type", "hex", lambda s: int(s, 16))
>   parser.add_argument(
>       "-l", "--load", type=lambda x: int(x, 0), default=0, help="Load address"
>   )
> +parser.add_argument(
> +    "-m", "--melfs", nargs='+', default=[], help="List of ELFs to include in multi-elf"
> +)

Let's just make this positional after "bin", I don't think there's 
anything else we could expect to go here.

Thanks,
Casey

>   parser.add_argument(
>       "-o", "--output", type=Path, default="u-boot.mbn", help="Output file"
>   )
> @@ -119,6 +122,18 @@ parser.add_argument(
>   args = parser.parse_args()
>   verbose = args.verbose
>   
> +if (len(args.melfs)):
> +    try:
> +        with open(args.output, "wb") as f:
> +            for path in args.melfs:
> +                with open(path, 'rb') as tmp:
> +                    f.write(tmp.read())
> +    except Exception as e:
> +        print(f"Error: {e}")
> +        sys.exit(1)
> +
> +    sys.exit(0)
> +
>   elf = Elf()
>   
>   data: bytes = args.bin.read()
> 

