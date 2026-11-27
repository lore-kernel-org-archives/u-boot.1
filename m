Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16237606A31C
	for <u-boot@archiver.kernel.org>; Fri, 27 Nov 2026 19:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=oAjMidvC;
	dkim=pass (4096-bit key, unprotected) header.d=canonical.com header.i=@canonical.com header.a=rsa-sha256 header.s=20251003 header.b=sKE1sL5D
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5655E812F5;
	Fri, 27 Nov 2026 19:07:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u9_LXQ6FUfr4; Fri, 27 Nov 2026 19:07:29 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org DF229812E4
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795806449;
	b=JurIuRf3Lr/yNwxj1JaiMYw0hLFJYeknU6M/4QCXgmJb7m2zTMahli5WiGXv4gpeoQVi
	 VNPd07NvjZ1RuGt2x/LTumNCBUwMp7t5XHjgRFuqatkoOAYt30BZxOF6DUq5RIG0NNYZI
	 GOl4hpjuwiLfbHCXV11LfLMkQib57mL0+7I+tR7dee/W0bi1UsbQBZTLN1zZPL1UFNB/h
	 ad2onMWycPXCG/3jNFp3h6L6c9o5vjIMyoR4VyDPTZ9GGDFIaFTYIym3pPU3yVjP/AMvX
	 ziDYA847Fe747JxC3KpBiazW4ZjsSZRmfVkLiAfRJ+EDXyS/XER5yPyhJd+9xgveLsQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795806449;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Received:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Message-ID:
	 Date:MIME-Version:User-Agent:Subject:To:Cc:References:
	 Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=xDxrAfWCQyfgrfhkvSzPvjhd98GaY9hXO6CVoM5z86A=;
	b=HoZD96+/wc1PEzuVJJZKDa7AKHtP5oRjCVpBmSPoUdoeWFUECs6GnZ1FN7qbLMQYM5qI
	 WJ8xemhVNJ2AGLrPJ7ogbSE4plGVmmPuuz4wlYKuKe1NvrRLLAw6XhAFJKagPZ+XI9xHq
	 nOijOieJbez4ubR196zunecTg1wgvrmOkTe7bKZ0eujcOCsLnInrJlanSsoQhGzrgoCmg
	 b0nKXFYHMlQ+RZzyMvwZafJQUvW3Yc7ybSrDZmKFjznKXIVAyuu+uSBOPyvNogUgvRzSr
	 uv00qX8ftoKhQCf8oTrfezaXJL2eL37mr1/MuNrxUWwbasVdC1srXos4jO18Vtv5GmQ==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795806449;
	bh=xDxrAfWCQyfgrfhkvSzPvjhd98GaY9hXO6CVoM5z86A=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=oAjMidvCjmfOdP1JZpm9E1Ui1fV8XcTih7bzPsCFRpKRzzrUR/VSPQu7faPhkq3Hn
	 I87YdQ7EwF0B5IjACM9Jo/zf+65XgjmQTFdOJDnk7vmSQClyQmbKFJLny2JLEJ3vfb
	 /gpj7Iig6IhGwrg6okiZ/8Kz/EImSrrzSrajyz9NaNXiHixXlvELBjWTK5aWSA4w49
	 v9RyINM1fulNOMSI3oLBphU3kUTL2S975G49q+UGbmEVyEpeEt0GGL84785sSK2JNA
	 462OvC90EX5nZ/lR8SgnXFs8dkXvAOevNDPufon0LCg1CradKOnnr7orYojzGVRUJu
	 EMsS9ClvT9yzQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id DF229812E4;
	Fri, 27 Nov 2026 19:07:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id A91B3373
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 19:07:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8F09860D64
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 19:07:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oXY4gh9Fbt_4 for <u-boot@lists.u-boot-project.org>;
 Fri, 27 Nov 2026 19:07:26 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 6F315607B0
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip=185.125.188.122
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp3.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=sKE1sL5D
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6F315607B0
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 19:07:24 +0000 (UTC)
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 0FDE84025B
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 19:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1795806442;
 bh=xDxrAfWCQyfgrfhkvSzPvjhd98GaY9hXO6CVoM5z86A=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=sKE1sL5D0laOKupPrTVqyLQf0suDFv21TfidGi/jkL8GzV4JvG74NC1zWo1bjdD4T
 +VZK7YJfjxOseRwN/FDKPQMQT17u0gBsFlxL0GDy0VobP/Npurx/O+Bb5bH8NRv4lv
 MpS1DqdQNg2TFapf1GiBaqXuUs296rwrNQPT5VKi37cWkK+IEOWriUC6rN2Df91sAQ
 +0mYUDtkLfpdp3ZzqtwM7umKhZgJUGDin4WDXa9e5AFvq6vPZtt0pu3ceKsgZ0aiVH
 qjoBrjflzA/LG7evdXG5YoHC3isVDU408lLZQvwcOIMJouPKsfsPLhJ0n3CGSueVTO
 pemH8x7RUoySj3u1yASu4PxbbQzV4k24KT9aW/x/puwntQ/hvWP+y+u+m8RL3jFOP6
 UqklixurgrdZthM1xf8MEuQ+IHH+VcJZ8er5R+xRhztxkJhLCMmh+/jZ9i8aDAmn+R
 xnYviv7jQRkwUWNCmeLnCx6qdh143DJwoZOaHMhA1xVsqN+x+OMbxqA4W/0l9DJrnK
 KUe1A+LQJpVBCPMVz4Ta9wmgWApzeILLlYQU0zYkQHwxEUKMxoMamlFlcdjVr7byp/
 y1jczg52g5LFdwhrwtHHLGCEtjEP2BuYBzhbJEtwEY2UPFTuww+vHXcuXj6w5NBxdg
 nj37WSEIUzcZpZJUVA7vtnEE=
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4a17741243eso11584415e9.0
 for <u-boot@lists.u-boot-project.org>; Fri, 27 Nov 2026 11:07:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795806441; x=1796411241;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xDxrAfWCQyfgrfhkvSzPvjhd98GaY9hXO6CVoM5z86A=;
 b=KEh29/v8r7cfRKzItHowlLHWRixOiQG8jIbIvOkievdKm+529DMEC0V4PCBwNfy/wN
 rBpVS+AJaxEM3TbZeQtkWZH7X3QvbuqrV9+kjTQ3uPp2Q0YI16aXhUuy1DZskg1axVda
 JQ8WjS+sNQyqV8TlZ0Ur7+t7fsGsYdo2L2KP+xFJ/405iJ7dQv6cP7L/tzlPk9+Ovtym
 q9akxiTiWDAGYV97rmorMFrO8paxAcgmsF9fRiYlt5eWBiuxedVy1AgujOWA1uTxV7fy
 ABO/zl8/JImRERUK6Jc7mXhSK2Kauez1E04/px+RXFjhUSaP6DpC9sazORi/PqHZbUI5
 uVyw==
X-Forwarded-Encrypted: i=1;
 AL+hErFzVP3VF8teHixMQZ6srRYxVuxsJ8ohERQtc2+s8l3oJkBG/ByIODlkTkm+m2LgKDW3jkp3ByU=@lists.u-boot-project.org
X-Gm-Message-State: APuU4Z95e+JB5gi34r/MFgbrl95ywTHDoykv4vxNgO3eW+vwRNglNn/8
 fY996QFSncepRHkj9qXRXIxAwUvmyRukN8tEI57NtNiVrdqHoGcItrupdMKNm7HE3YZ7XQ6BB+A
 1zZcrP6Yg004DwKvDhoUhyu2XLWY7DcgxJ1/UMNIfK3WeUvOe/stamT6o6apooEr7dctsjYgzdI
 oWAmAH4XIFCA==
X-Gm-Gg: AZFdTZdK5pCO0OYS0IZXf9jPK0N2IQdkDxINt25rpmq3d8JcDT5wpP+B1zQrLEx7tOY
 I28qjUtUbyJRLRmnAfLAjCu3qc75H+bnNl5968GEA4wsL4vLDuUmrQt6mEE3jHJEFmx9vji4juJ
 7Kv0974ppwFOZaJSf6TFAnRE7uzW7v+ErMTzu2eTpNnIS0TciKsqUl30qUdnnoH+PZYbSj248aJ
 yCKK0ln6mgn1YFdRoJg978RkwVkujFS3L08QUSCejuE615K7KJathGuV1qZGheMG7nPSSrJDiqA
 6PEpVKGvbGA56+GGJm6/kAQOA1Glrs4C4ElnaNlIbmDKjpfZuUM2TOjYXgTEYy2OSR7TZ6+K5DO
 2bqVTkvs/VrulOSz1VHozB/yDq9ApZXb049nRen3nHGhBq7NqkfrClO3jJIBj50ZgxmLEzHKyw6
 Pe3ohkecKVswsCAY3fwWprbIGp7TIUywJB8UTAAaXDI7fxv3IKM+uQe9mbfJATz00xCQ319Hipc
 Q==
X-Received: by 2002:a05:600c:4f0d:b0:4bb:5c97:f4b1 with SMTP id
 5b1f17b1804b1-4bb8881941bmr572107525e9.24.1795806441538; 
 Fri, 27 Nov 2026 11:07:21 -0800 (PST)
X-Received: by 2002:a05:600c:4f0d:b0:4bb:5c97:f4b1 with SMTP id
 5b1f17b1804b1-4bb8881941bmr572106965e9.24.1795806441058; 
 Fri, 27 Nov 2026 11:07:21 -0800 (PST)
Received: from ?IPV6:2a02:908:1242:30e0:c495:9f2a:a9d7:a02f?
 ([2a02:908:1242:30e0:c495:9f2a:a9d7:a02f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb906c089dsm432337105e9.1.2026.11.27.11.07.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Nov 2026 11:07:20 -0800 (PST)
Message-ID: <14990744-782e-4159-99a8-260f960a028b@canonical.com>
Date: Fri, 27 Nov 2026 20:07:18 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] lib: vsprintf: add %uZ to print sizes
To: Padmarao Begari <padmarao.begari@amd.com>
Cc: git@amd.com, Tom Rini <trini@konsulko.com>,
 u-boot@lists.u-boot-project.org, michal.simek@amd.com,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>
References: <20261105051715.215560-1-padmarao.begari@amd.com>
 <20261105051715.215560-2-padmarao.begari@amd.com>
Content-Language: en-US
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
In-Reply-To: <20261105051715.215560-2-padmarao.begari@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/5/26 06:16, Padmarao Begari wrote:
> A size with a binary unit can only be printed to the console with
> print_size(). Code which builds a string, such as a boot menu entry,
> has to format the size itself.
> 
> Add a Z suffix to the %u conversion which prints the value as a size in
> bytes with a binary unit, as print_size() does, so that sizes can be
> printed with printf() and its variants:
> 
> 	printf("%lluZ\n", 0x113000ULL);		/* 1 MiB */
> 	printf("%.3lluZ\n", 0x113000ULL);	/* 1.074 MiB */
> 
> The precision is the number of decimal places, with the last one rounded
> and trailing zeros left out, so that "%.1lluZ" prints the same as
> print_size(). The Z only has this meaning after %u, since an existing
> format string has "%dZ" followed by other text. Compilers which check
> format strings see the Z as an ordinary character, so this does not
> cause warnings.
> 
> Document the format and add tests, including one which checks that
> "%.1lluZ" prints the same as print_size() for a range of sizes.
> 
> Suggested-by: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
> Signed-off-by: Padmarao Begari <padmarao.begari@amd.com>
> ---
> Changes in v3:
> - New patch, replacing "lib: display_options: add snprint_size()":
>    print sizes with a Z suffix to the %u conversion, as suggested by
>    Heinrich Schuchardt
> 
> checkpatch reports 'Please use a blank line after
> function/struct/union/enum declarations' for each COMMON_TEST() line.
> COMMON_TEST() is placed directly after its test function, as in the
> other tests.
> 
>   doc/develop/printf.rst | 30 +++++++++++++
>   lib/vsprintf.c         | 98 ++++++++++++++++++++++++++++++++++++++++++
>   test/common/print.c    | 97 +++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 225 insertions(+)
> 
> diff --git a/doc/develop/printf.rst b/doc/develop/printf.rst
> index 99d05061b14..33f2e027fa0 100644
> --- a/doc/develop/printf.rst
> +++ b/doc/develop/printf.rst
> @@ -127,6 +127,36 @@ size_t              %zu, %zx, %zX
>   ssize_t             %zd, %zx, %zX
>   =================== ==================
>   
> +Sizes
> +-----
> +
> +%uZ, %luZ, %lluZ, %zuZ
> +	prints an unsigned integer as a size in bytes with a binary unit:
> +	"xxx Bytes" below 1 KiB, otherwise "xxx KiB", "xxx MiB" and so on up
> +	to "xxx EiB", using the largest unit which gives at least 1.
> +
> +	The precision is the number of decimal places, at most 9. The last
> +	one is rounded and trailing zeros are left out. Without a precision,
> +	the size is rounded to a whole number of the unit. A field width pads
> +	the whole string with spaces.
> +
> +	"%.1lluZ" prints a size the same way as print_size().
> +
> +	The Z only has this meaning after %u. After other conversions, such
> +	as %d or %x, it is printed as a normal character. The SPL and TPL
> +	tiny printf() does not support it.
> +
> +=================== ======================= ==============
> +Format              Value                   Output
> +=================== ======================= ==============
> +%lluZ               0x113000                1 MiB
> +%.1lluZ             0x113000                1.1 MiB
> +%.3lluZ             0x113000                1.074 MiB
> +%.3lluZ             0x100000                1 MiB
> +%zuZ                512                     512 Bytes
> +%10lluZ             1024                    "     1 KiB"
> +=================== ======================= ==============
> +

Hello Padmarao,

Overall the series looks good to me. I am just a bit surprised by the 
formatting of numbers.

For floating point numbers %f uses fixed number of decimals and %g uses 
a fixed number of significant digits.

%8s = %.3f
       3. = 3.000
      3.1 = 3.100
     3.14 = 3.140
    3.142 = 3.142
  3.14159 = 3.142
  31.4159 = 31.416
  314.159 = 314.159
%8s = %.3g
       3. = 3
      3.1 = 3.1
     3.14 = 3.14
    3.142 = 3.14
  3.14159 = 3.14
  31.4159 = 31.4
  314.159 = 314

Your code does neither the one nor the other.

printf("%llx = %.3lluZ\n", 0x3FF80000LLU, 0x3FF80000LLU);
printf("%llx = %.3lluZ\n", 0x3FF80001LLU, 0x3FF80001LLU);
printf("%llx = %.3lluZ\n", 0x3FFFFDF2LLU, 0x3FFFFDF2LLU);
printf("%llx = %.3lluZ\n", 0x3FFFFDF3LLU, 0x3FFFFDF3LLU);
printf("%llx = %.3lluZ\n", 0x3FFFFDF4LLU, 0x3FFFFDF4LLU);
printf("%llx = %.3lluZ\n", 0x3FFFFFFFLLU, 0x3FFFFFFFLLU);
printf("%llx = %.3lluZ\n", 0x40000000LLU, 0x40000000LLU);

3ff80000 = 1023.5 MiB
3ff80001 = 1023.5 MiB
3ffffdf2 = 1023.999 MiB
3ffffdf3 = 1023.999 MiB
3ffffdf4 = 1 GiB
3fffffff = 1 GiB
40000000 = 1 GiB

I would have preferred 3 significant digits for %.3lluZ:

3E77FFFF = 999. MiB
3E780000 = 0.98 GiB
3F5C28F5 = 0.99 GiB
3ff80000 = 1.00 GiB
40000000 = 1.00 GiB

This would make best use of restricted screen space.

But as your %.1lluZ matches the behavior of print_size() I will take it 
as is. Follow up work can replace print_size() occurences.

Reviewed-by: Heinrich Schuchardt <xypron.glpk@gmx.de>

>   Characters
>   ----------
>   
> diff --git a/lib/vsprintf.c b/lib/vsprintf.c
> index 49dc9c38c65..a14f8c600b7 100644
> --- a/lib/vsprintf.c
> +++ b/lib/vsprintf.c
> @@ -151,6 +151,7 @@ static noinline char *put_dec(char *buf, uint64_t num)
>   #define SMALL	32		/* Must be 32 == 0x20 */
>   #define SPECIAL	64		/* 0x */
>   #define ERRSTR	128		/* %dE showing error string if enabled */
> +#define SIZEUNIT	256		/* %uZ showing a size with a unit */
>   
>   /*
>    * Macro to add a new character to our output string, but only if it will
> @@ -281,6 +282,94 @@ static char *string(char *buf, char *end, const char *s, int field_width,
>   	return buf;
>   }
>   
> +/* Most decimal places which %uZ shows */
> +#define SIZE_MAX_DECIMALS	9
> +
> +/**
> + * size_string() - Print a size with a binary unit, for %uZ
> + *
> + * Print a size in bytes as "xxx Bytes" below 1 KiB, and otherwise as
> + * "xxx KiB", "xxx MiB", ... "xxx EiB", with the largest unit that gives at
> + * least 1. The precision is the number of decimal places, at most
> + * SIZE_MAX_DECIMALS, with the last one rounded and trailing zeros left out,
> + * so that "%.1lluZ" prints the same as print_size(). There are no decimal
> + * places without a precision.
> + *
> + * @buf:	Buffer to write to
> + * @end:	End of the buffer
> + * @size:	Size in bytes
> + * @field_width:	Minimum width of the output, padded with spaces
> + * @precision:	Number of decimal places, -1 for none
> + * @flags:	Formatting flags; only LEFT is used
> + * Return:	Pointer to the end of the output in @buf
> + */
> +static char *size_string(char *buf, char *end, u64 size, int field_width,
> +			 int precision, int flags)
> +{
> +	static const char units[] = "KMGTPE";
> +	char tmp[32], *p, *tmp_end = tmp + sizeof(tmp);
> +	int unit, shift, decimals, i;
> +	u64 whole, rem, mask;
> +	u32 frac, scale;
> +
> +	/* Find the largest unit which gives at least 1 */
> +	for (unit = -1; unit + 1 < (int)ARRAY_SIZE(units) - 1; unit++) {
> +		if (!(size >> (10 * (unit + 2))))
> +			break;
> +	}
> +
> +	if (unit < 0) {
> +		p = number(tmp, tmp_end, size, 10, -1, -1, 0);
> +		strcpy(p, " Bytes");
> +
> +		return string(buf, end, tmp, field_width, -1, flags);
> +	}
> +
> +	shift = 10 * (unit + 1);
> +	mask = (1ULL << shift) - 1;
> +	whole = size >> shift;
> +	rem = size & mask;
> +	decimals = precision < 0 ? 0 : min(precision, SIZE_MAX_DECIMALS);
> +
> +	/* Work out each decimal place in turn, then round the last one */
> +	frac = 0;
> +	scale = 1;
> +	for (i = 0; i < decimals; i++) {
> +		rem *= 10;
> +		frac = frac * 10 + (rem >> shift);
> +		rem &= mask;
> +		scale *= 10;
> +	}
> +	if (rem >> (shift - 1))
> +		frac++;
> +
> +	/* Rounding can carry into the whole part, and on into the next unit */
> +	if (frac >= scale) {
> +		frac -= scale;
> +		whole++;
> +		if (whole == 1024 && units[unit + 1]) {
> +			whole = 1;
> +			unit++;
> +		}
> +	}
> +
> +	while (decimals > 0 && !(frac % 10)) {
> +		frac /= 10;
> +		decimals--;
> +	}
> +
> +	p = number(tmp, tmp_end, whole, 10, -1, -1, 0);
> +	if (decimals) {
> +		*p++ = '.';
> +		p = number(p, tmp_end, frac, 10, -1, decimals, 0);
> +	}
> +	*p++ = ' ';
> +	*p++ = units[unit];
> +	strcpy(p, "iB");
> +
> +	return string(buf, end, tmp, field_width, -1, flags);
> +}
> +
>   /* U-Boot uses UTF-16 strings in the EFI context only. */
>   static __maybe_unused char *string16(char *buf, char *end, u16 *s,
>   				     int field_width, int precision, int flags)
> @@ -726,6 +815,10 @@ repeat:
>   			flags |= SIGN;
>   		/* fallthrough */
>   		case 'u':
> +			if (*fmt == 'u' && fmt[1] == 'Z') {
> +				flags |= SIZEUNIT;
> +				fmt++;
> +			}
>   			break;
>   
>   		default:
> @@ -755,6 +848,11 @@ repeat:
>   			if (flags & SIGN)
>   				num = (signed int) num;
>   		}
> +		if (flags & SIZEUNIT) {
> +			str = size_string(str, end, num, field_width, precision,
> +					  flags);
> +			continue;
> +		}
>   		str = number(str, end, num, base, field_width, precision,
>   			     flags);
>   		if (IS_ENABLED(CONFIG_ERRNO_STR) && (flags & ERRSTR)) {
> diff --git a/test/common/print.c b/test/common/print.c
> index 27fdb444d0d..1d2ee8f3839 100644
> --- a/test/common/print.c
> +++ b/test/common/print.c
> @@ -164,6 +164,103 @@ static int print_printf(struct unit_test_state *uts)
>   }
>   COMMON_TEST(print_printf, 0);
>   
> +/* Test printing sizes with %uZ */
> +static int print_size_unit(struct unit_test_state *uts)
> +{
> +	char str[40];
> +
> +	/* The integer types */
> +	snprintf(str, sizeof(str), "%uZ", 0x100000);
> +	ut_asserteq_str("1 MiB", str);
> +	snprintf(str, sizeof(str), "%luZ", 0x100000UL);
> +	ut_asserteq_str("1 MiB", str);
> +	snprintf(str, sizeof(str), "%lluZ", 0x100000ULL);
> +	ut_asserteq_str("1 MiB", str);
> +	snprintf(str, sizeof(str), "%zuZ", (size_t)0x100000);
> +	ut_asserteq_str("1 MiB", str);
> +
> +	/* Below 1 KiB, and each unit */
> +	snprintf(str, sizeof(str), "%lluZ", 0ULL);
> +	ut_asserteq_str("0 Bytes", str);
> +	snprintf(str, sizeof(str), "%lluZ", 1023ULL);
> +	ut_asserteq_str("1023 Bytes", str);
> +	snprintf(str, sizeof(str), "%lluZ", 1ULL << 10);
> +	ut_asserteq_str("1 KiB", str);
> +	snprintf(str, sizeof(str), "%lluZ", 1ULL << 30);
> +	ut_asserteq_str("1 GiB", str);
> +	snprintf(str, sizeof(str), "%lluZ", 1ULL << 40);
> +	ut_asserteq_str("1 TiB", str);
> +	snprintf(str, sizeof(str), "%lluZ", 1ULL << 50);
> +	ut_asserteq_str("1 PiB", str);
> +	snprintf(str, sizeof(str), "%lluZ", 1ULL << 60);
> +	ut_asserteq_str("1 EiB", str);
> +	snprintf(str, sizeof(str), "%.1lluZ", ~0ULL);
> +	ut_asserteq_str("16 EiB", str);
> +
> +	/* The precision is the number of decimal places */
> +	snprintf(str, sizeof(str), "%lluZ", 0x113000ULL);
> +	ut_asserteq_str("1 MiB", str);
> +	snprintf(str, sizeof(str), "%.1lluZ", 0x113000ULL);
> +	ut_asserteq_str("1.1 MiB", str);
> +	snprintf(str, sizeof(str), "%.3lluZ", 0x113000ULL);
> +	ut_asserteq_str("1.074 MiB", str);
> +	snprintf(str, sizeof(str), "%.*lluZ", 3, 0x113000ULL);
> +	ut_asserteq_str("1.074 MiB", str);
> +
> +	/* Leading zeros of the decimals are kept, trailing ones left out */
> +	snprintf(str, sizeof(str), "%.3lluZ", 0x101000ULL);
> +	ut_asserteq_str("1.004 MiB", str);
> +	snprintf(str, sizeof(str), "%.3lluZ", 0x100000ULL);
> +	ut_asserteq_str("1 MiB", str);
> +	snprintf(str, sizeof(str), "%.3lluZ", 0x180000ULL);
> +	ut_asserteq_str("1.5 MiB", str);
> +
> +	/* Rounding, also into the next unit */
> +	snprintf(str, sizeof(str), "%lluZ", 0x180000ULL);
> +	ut_asserteq_str("2 MiB", str);
> +	snprintf(str, sizeof(str), "%.1lluZ", (1ULL << 30) - 1);
> +	ut_asserteq_str("1 GiB", str);
> +
> +	/* Field width */
> +	snprintf(str, sizeof(str), "[%10lluZ]", 1ULL << 10);
> +	ut_asserteq_str("[     1 KiB]", str);
> +	snprintf(str, sizeof(str), "[%-10lluZ]", 1ULL << 10);
> +	ut_asserteq_str("[1 KiB     ]", str);
> +
> +	/* Only %u takes the Z */
> +	snprintf(str, sizeof(str), "%dZ %xZ", 0x100000, 0x100000);
> +	ut_asserteq_str("1048576Z 100000Z", str);
> +
> +	/* A size which does not fit is truncated like any other output */
> +	ut_asserteq(9, snprintf(str, 5, "%.3lluZ", 0x113000ULL));
> +	ut_asserteq_str("1.07", str);
> +
> +	return 0;
> +}
> +COMMON_TEST(print_size_unit, 0);
> +
> +/* Test that %.1lluZ prints the same as print_size() */
> +static int print_size_unit_compat(struct unit_test_state *uts)
> +{
> +	static const u64 sizes[] = {
> +		0, 1, 999, 1023, 1024, 1025, 1536, 1588, 1638, 0x3ffff,
> +		0xfffff, 0x100000, 0x113000, 0x1f00000, 0x7e00000,
> +		0x3fffffff, 0x40000000, 0x76c0000000ULL, 0xe8d4a51000ULL,
> +		0xfffffffffffULL, 1ULL << 40, (1ULL << 50) + (1ULL << 49),
> +		(1ULL << 60) - 1, 3ULL << 60, ~0ULL,
> +	};
> +	int i;
> +
> +	for (i = 0; i < ARRAY_SIZE(sizes); i++) {
> +		print_size(sizes[i], "\n");
> +		ut_assert_nextline("%.1lluZ", sizes[i]);
> +	}
> +	ut_assert_console_end();
> +
> +	return 0;
> +}
> +COMMON_TEST(print_size_unit_compat, UTF_CONSOLE);
> +
>   static int print_display_buffer(struct unit_test_state *uts)
>   {
>   	u8 *buf;

