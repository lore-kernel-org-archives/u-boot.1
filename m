Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55FB7C61DC4
	for <u-boot@archiver.kernel.org>; Thu, 27 Aug 2026 13:39:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A8F0C80E25;
	Thu, 27 Aug 2026 13:39:58 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id RUKBq4GMpPYX; Thu, 27 Aug 2026 13:39:57 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787837997;
	bh=T1S4OUNhx/dRuNbDRWNKDSkAxb4N876rtCWhDQFWKZg=;
	h=From:Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=kUkpvgYE4ZCFJy/ptfI5vFNVq+NQ4PYFOcjZ2GMImWHw+ENQCqX86S9MAQaKG/6oV
	 Ks3lcBq0AF8md8c+Y98prI5uhhSB7gZvojF+fyJRSbX9QU/BL7iCPl6kyB35PK2+7D
	 dLt38IuslObSiCJi8J3qMAsqxhikA5FOLZ8zHx1a3zDP+VDoLR5xVzObZjRrLpcSY2
	 4nzAQRF144hsBj2kvV0CRW9nveWca7IK8xUQy41Fyp8dXzdCfWASjurXCFxcZp2Jxs
	 jqsA5Lk8/EY8ZwklBB1mpFYbKBOzhQbL5ThQ7+G1kI5NLq+6HJD8pj81BkqR1Bhho8
	 ysmfZPfk9ok5Q==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9C13580E2A;
	Thu, 27 Aug 2026 13:39:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists1.osuosl.org (Postfix) with ESMTP id A7FA639E
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 13:39:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 8EFFB40308
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 13:39:56 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id HX9ytoYCM5dZ for <u-boot@lists.u-boot-project.org>;
 Thu, 27 Aug 2026 13:39:55 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.122;
 helo=smtp-relay-internal-0.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=canonical.com
Authentication-Results: smtp2.osuosl.org; dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=TohX/gbL
Received: from smtp-relay-internal-0.canonical.com
 (smtp-relay-internal-0.canonical.com [185.125.188.122])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DFF4C40304
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 13:39:53 +0000 (UTC)
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id C35443F2B1
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 13:39:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1787837990;
 bh=T1S4OUNhx/dRuNbDRWNKDSkAxb4N876rtCWhDQFWKZg=;
 h=From:Message-ID:Date:MIME-Version:Subject:To:Cc:References:
 In-Reply-To:Content-Type;
 b=TohX/gbL5JL9Lc8MXE4FGUZ0W9RnlW/5QDc+tMrW5UOrTYK/X/+S9vNzPc985bzXI
 w+3wd9ybVtjyNxd4K2SvIyQ+VRM4ZR3NiS+G593CMUUWRWoPr4vUiWMdu728Vd+AYA
 SzEzCpmsmNwzQAOOuoTTsk/2iVB2pDm9MysqhEb1SgV/Q5RJzfre5nMYi6/w0x3cif
 L6YtAoB23oQaxXKCr6tCtIfEzbtonWwA64lDqWu3dD9GTtS2MdgVWGnZTxGgxyfRqJ
 KTgTb0bTPbBv2j3zsZeXjIO+JeNDLooFFhj1oi+MSOj2+EwlVd5x8DxYrLOerPfkK5
 tVbQOYNXjQNGiuMG+lwRNJ8Z2VZWmYEwAHosQLVtcDk6ay9UpyeyYUKBw0pAlFW9K/
 wrnpaCjR3ZXVJj5GViMmxA1uT7I/F6sMd3urJQ5NKHUaGK9zQp86umZGJUXuxbu9DP
 CUqEhfkKdI8QafiQQl4iu42QW8ETQU6YoYJExmioTIknGWWuNW3FHwTFpHkw15D0zl
 266/gnRQU+HtxQraBfUWv7aphh1BHrGflK051HZ3Vpo7IgZI7HeZcTP7kSGCpTAhT0
 4cyWcRiDmsdJk7IXHuGP8jb3VHrBBijvTKCwk2rz9AGW5XvNeYnycg/gkZBP9trfPk
 KY5davRg4MBcOxqpL6VoTj2M=
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4954c2d4081so17663405e9.2
 for <u-boot@lists.u-boot-project.org>; Thu, 27 Aug 2026 06:39:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787837989; x=1788442789;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=T1S4OUNhx/dRuNbDRWNKDSkAxb4N876rtCWhDQFWKZg=;
 b=W7I5A9igPduQ0WUpoakZeEfe9Tq0+d87JI9SyGU4PG+AUGixkw/DJmwMmuIHalYNbk
 HAErBQvbigwvIB+jNv2aSjUt3kLdCXG9S9aOyVdFJ7B2WBPJP0RlCx+PufPwNd8b71OS
 3ZPc3aby8S4vcat556JvFaByIfob6Fr0KFOyN7Jv8AHByMToibdSq2RVReM+484JoVgD
 N/Tj84CMVcYl8rMfUtHqeM+BCtsySEDHKY5aHtACmkC+OOgn9MaIqoWxIZbcrEVB+bkU
 BE/5o1zp0XxtOKNWCe+K4c9MxHg8gyay/gZPx95Uzb1YYcS1HAvObi9v8yAML1TXovAs
 R7nw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr2mRcFqCSgdsdK7Aw/A+DG0dia1A0MrcYbf81RxexLveuC6UVwmGDpxMji3Mg1Y1esqB+GDdk=@lists.u-boot-project.org
X-Gm-Message-State: AFuF++k9ED9solww5T900Yh8s9DkOZhnbPinks9+dvL3MJHZLB+jbiDK
 KBI21S+/pbVhvTDAGS+zIajtDVHqcNzhVsSosiqNXNSI32ByXqyprJrLF806HN7wPQnzXTx13ob
 lG5/2xCn3IqL5XsjVu8rttTTzyyIiHdCV9KpD90AyAL+w3YT5qegkCvX5H+oWZwvd1A8cOSuXNJ
 H6FrJFgBKYTg==
X-Gm-Gg: AR+sD11s5h8jmOTiL0SYDju8MdJipbvCmAxPzJ4OP3fIfhP6yPHPb2a5ZaCbgDOLBCe
 aM5ZqdrqBEZeqyr3zEaSHj6vIXH8O/p3zautv40kzzbSn5vH7qkrdI0zA50B8GgVPKpwkci2KAI
 Y+TiNOyfpfX8I8iMYXpnGFph3uO6f5/AetWSTl0WMPPyihC6MWbZaGAgXM4cT8FH0lTTLbCTfJe
 i3j9rLeMXMT769Qrpf8cQpqrGOADfq5CNUJZ2x0CGbh9QXROLcQozfwg5iICT0Ukgfz17CnUj0k
 8j6IsK3RHIzfPhyOGwpidHRItm07UIDPHgTs11K7Jfj5tbhz2Vu09FFE52WHkU0Obv6I90BHTSF
 n8ulOAHNrlFiChfywe1uK3s9RLquufsHGoBunJE95HdaVqGTstIPgQPVR/zdqSlD9g5s/4qHeIZ
 N45Kiykrk=
X-Received: by 2002:a05:600c:c0da:b0:499:5f7a:7ea2 with SMTP id
 5b1f17b1804b1-499dc8206famr169280175e9.12.1787837989603; 
 Thu, 27 Aug 2026 06:39:49 -0700 (PDT)
X-Received: by 2002:a05:600c:c0da:b0:499:5f7a:7ea2 with SMTP id
 5b1f17b1804b1-499dc8206famr169279215e9.12.1787837989151; 
 Thu, 27 Aug 2026 06:39:49 -0700 (PDT)
Received: from ?IPV6:2a02:908:1242:30e0:d8da:da16:d52e:e57d?
 ([2a02:908:1242:30e0:d8da:da16:d52e:e57d])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49b4c321184sm67274135e9.11.2026.08.27.06.39.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Aug 2026 06:39:48 -0700 (PDT)
From: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
X-Google-Original-From: Heinrich Schuchardt <xypron.debian@gmx.de>
Message-ID: <ea3cbf91-f525-47c8-870f-79e8ef09e30e@gmx.de>
Date: Thu, 27 Aug 2026 15:39:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] test: lib/uuid: Fix endianness for dynamic GUIDs
To: Alexey Charkov <alchark@flipper.net>
Cc: Tom Rini <trini@konsulko.com>, Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Wojciech Dubowik <Wojciech.Dubowik@mt.com>,
 Casey Connolly <casey.connolly@linaro.org>, u-boot@lists.u-boot-project.org
References: <20260827-uuid-be-v1-1-9dc3b12cd691@flipper.net>
Content-Language: en-US
In-Reply-To: <20260827-uuid-be-v1-1-9dc3b12cd691@flipper.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 8/27/26 15:00, Alexey Charkov wrote:
> If LIB_UUID is enabled on a big-endian board, such as when it is pulled
> in by EFI_PARTITION, its tests will fail due to the dynamic capsule GUIDs
> computed by lib_test_dynamic_uuid() using native endianness for the UTF-16
> image name, instead of little-endian:
> 
>    malta # ut lib lib_test_dynamic_uuid
>    Test: dynamic_uuid: uuid.c
>    test/lib/uuid.c:114, lib_test_dynamic_uuid_case(): expected_uuid = uuid_str: Expected "985f2937-7c2e-5e9a-8a5e-8e063312964b", got "829f5cb0-1a07-5718-8774-4514bda82c39"
>    Test 'dynamic_uuid' failed 1 times
>    Tests run: 1, 2 ms, average: 2 ms, failures: 1
>    exit not allowed from main input shell.
>    malta #
> 
> Add explicit endianness conversion to the test and to other similar
> callers of gen_v5_guid() to make sure they work uniformly regardless of
> the host or target endianness.
> 
> Signed-off-by: Alexey Charkov <alchark@flipper.net>

Thank you for reporting that the test fails on big endian systems.

In lib_test_dynamic_uuid() we define define dynamic_uuid_test_data 
test_data[].images as u16 string. On a big endian system the characters 
of the string will not be stored in the same sequence as on a low endian 
system so the UUID generated in gen_v5_guid() is expected to be different.

test_data[].images should contain unique sequences of bytes.

The relevant code was introduced with
26e16a850e64 ("test: lib/uuid: add unit tests for dynamic UUIDs")

With that I don't think that the EFI changes are needed. Anyway UEFI is 
little endian only.

Best regards

Heinrich

> ---
> This was uncovered [1] while adding tests for GPT partition labels on big
> endian boards, which pulls in PARTITION_UUIDS, which in turn pulls in
> LIB_UUID and its tests. Turns out no BE board in CI ever enabled LIB_UUID,
> so this went unnoticed to date.
> 
> The immediate users of this code other than the test suite are EFI capsule
> updates, which is unlikely to be relevant for anything big endian (given
> that UEFI is little endian), but the test suite itself seems to be a good
> reason to get this fixed.
> 
> No functional change on little endian either way.
> 
> [1] https://git.u-boot-project.org/u-boot/contributors/alchark/u-boot/-/pipelines/1101
> ---
>   include/u-boot/uuid.h         |  5 +++++
>   lib/efi_loader/efi_firmware.c | 19 ++++++++++++++++++-
>   test/lib/uuid.c               | 15 ++++++++++++++-
>   tools/mkeficapsule.c          |  3 ++-
>   4 files changed, 39 insertions(+), 3 deletions(-)
> 
> diff --git a/include/u-boot/uuid.h b/include/u-boot/uuid.h
> index 7f8414dc906c..acdf3a85a6cb 100644
> --- a/include/u-boot/uuid.h
> +++ b/include/u-boot/uuid.h
> @@ -149,6 +149,11 @@ struct efi_guid;
>   /**
>    * gen_v5_guid() - generate little endian v5 GUID from namespace and other seed data.
>    *
> + * The seed data is hashed as raw bytes, so any of it that is not a byte string
> + * has to be supplied in a fixed byte order for the result to be reproducible.
> + * UTF-16 seed data, such as a firmware image name, must therefore be passed
> + * little-endian, which is the byte order the UEFI specification uses for it.
> + *
>    * @namespace:   pointer to UUID namespace salt
>    * @guid:        pointer to allocated GUID output
>    * @...:         NULL terminated list of seed data as pairs of pointers
> diff --git a/lib/efi_loader/efi_firmware.c b/lib/efi_loader/efi_firmware.c
> index b41969c70fde..7f3b2da3ef89 100644
> --- a/lib/efi_loader/efi_firmware.c
> +++ b/lib/efi_loader/efi_firmware.c
> @@ -279,15 +279,32 @@ static efi_status_t efi_gen_capsule_guids(void)
>   	}
>   
>   	for (i = 0; i < update_info.num_images; i++) {
> +		size_t len, j;
> +		u16 *name_le;
> +
>   		if (!fw_array[i].fw_name) {
>   			log_err("fw_name is not defined. Not generating capsule GUIDs\n");
>   			return EFI_INVALID_PARAMETER;
>   		}
> +
> +		/*
> +		 * The name is hashed as UTF-16LE, so that a big-endian board
> +		 * arrives at the same GUID as mkeficapsule running on a
> +		 * little-endian build host.
> +		 */
> +		len = u16_strlen(fw_array[i].fw_name);
> +		name_le = calloc(len, sizeof(*name_le));
> +		if (!name_le)
> +			return EFI_OUT_OF_RESOURCES;
> +		for (j = 0; j < len; j++)
> +			name_le[j] = cpu_to_le16(fw_array[i].fw_name[j]);
> +
>   		gen_v5_guid(&namespace,
>   			    &fw_array[i].image_type_id,
>   			    compatible, strlen(compatible),
> -			    fw_array[i].fw_name, u16_strlen(fw_array[i].fw_name) * sizeof(uint16_t),
> +			    name_le, len * sizeof(*name_le),
>   			    NULL);
> +		free(name_le);
>   
>   		log_debug("Image %ls UUID %pUl\n", fw_array[i].fw_name,
>   			  &fw_array[i].image_type_id);
> diff --git a/test/lib/uuid.c b/test/lib/uuid.c
> index d00e9563a472..1c66021af3ed 100644
> --- a/test/lib/uuid.c
> +++ b/test/lib/uuid.c
> @@ -10,6 +10,7 @@
>   
>   #include <charset.h>
>   #include <u-boot/uuid.h>
> +#include <asm/byteorder.h>
>   #include <test/lib.h>
>   #include <test/test.h>
>   #include <test/ut.h>
> @@ -102,12 +103,24 @@ static int lib_test_dynamic_uuid_case(struct unit_test_state *uts,
>   	for (j = 0; data->images[j]; j++) {
>   		const char *expected_uuid = data->expected_uuids[j];
>   		const u16 *image = data->images[j];
> +		u16 image_le[64];
>   		efi_guid_t uuid;
>   		char uuid_str[37];
> +		size_t len, k;
> +
> +		/*
> +		 * u"..." is native-endian, but the name is hashed as UTF-16LE
> +		 * so that the GUID does not depend on the endianness of the
> +		 * board or of the host running mkeficapsule.
> +		 */
> +		len = u16_strlen(image);
> +		ut_assert(len <= ARRAY_SIZE(image_le));
> +		for (k = 0; k < len; k++)
> +			image_le[k] = cpu_to_le16(image[k]);
>   
>   		gen_v5_guid(&namespace, &uuid,
>   			    data->compatible, strlen(data->compatible),
> -			    image, u16_strlen(image) * sizeof(uint16_t),
> +			    image_le, len * sizeof(*image_le),
>   			    NULL);
>   		uuid_bin_to_str((unsigned char *)&uuid, uuid_str, UUID_STR_FORMAT_GUID);
>   
> diff --git a/tools/mkeficapsule.c b/tools/mkeficapsule.c
> index ec640c57e8a5..55a58f07d56e 100644
> --- a/tools/mkeficapsule.c
> +++ b/tools/mkeficapsule.c
> @@ -1004,8 +1004,9 @@ static int genguid(int argc, char **argv)
>   			return -1;
>   		}
>   
> +		/* The name is hashed as UTF-16LE, whatever this host is */
>   		for (int i = 0; i < namelen; i++)
> -			fw_image[i] = (uint16_t)argv[idx][i];
> +			fw_image[i] = cpu_to_le16((uint16_t)argv[idx][i]);
>   
>   		gen_v5_guid((struct uuid *)&namespace, &image_type_id,
>   			    compatible, strlen(compatible),
> 
> ---
> base-commit: 964ad5b5c91b7be56e443e899d7f873e6aa8c9fc
> change-id: 20260827-uuid-be-56657e7aa80e
> 
> Best regards,
> --
> Alexey Charkov <alchark@flipper.net>
> 

