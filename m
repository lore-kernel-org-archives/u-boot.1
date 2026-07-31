Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03800C54F54
	for <u-boot@archiver.kernel.org>; Fri, 31 Jul 2026 11:08:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C715160AAE;
	Fri, 31 Jul 2026 11:08:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vdr8y7AoE740; Fri, 31 Jul 2026 11:08:32 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 06D4A60A51
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org ; s=default; t=1785496112;
	bh=BAQPL7FwXEM4z5BzgItp/CTWcpbGh3Q6zxe+dDlZ0/I=;
	h=Date:Subject:To:Cc:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From:Reply-To:From;
	b=JPaHXmEHV7nAGKfhXJCQJZ64SCh4Wj2D5DSSxp5MgOTqGFgK565Sf+qZrklRurHN8
	 xyasML73e2WzkdaTZe+thRXEx+T0hRfaY8+Fhp1+IZPY7c+gqEG79oP6O/L/ch9HHz
	 2cbWLTPmvJBDrVSWFaid1Mh0tMl/DpqGJxLvjxQUwAy+EAgykuHjnoAAiDHWQUF8ZG
	 JCoYZz50FbUsCJUMP41t85RydLAdXJhlnn6O3B+eDDGDrIPX1mzXepnbWeks6r26Yf
	 LME2YkqeQGt/B9R140Kr5mm/fPom0r2H/rptnWqvPz181jHfK2tj0+0Y6TDZ6XR6bQ
	 bGUbz9KeCG2Mg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 06D4A60A51;
	Fri, 31 Jul 2026 11:08:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 555B827C
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 11:08:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3B6EB40F94
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 11:08:30 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id us6cKmE-U7mq for <u-boot@lists.u-boot-project.org>;
 Fri, 31 Jul 2026 11:08:29 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=185.125.188.123;
 helo=smtp-relay-internal-1.canonical.com;
 envelope-from=heinrich.schuchardt@canonical.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org CA93340E7A
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org CA93340E7A
Received: from smtp-relay-internal-1.canonical.com
 (smtp-relay-internal-1.canonical.com [185.125.188.123])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CA93340E7A
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 11:08:28 +0000 (UTC)
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8F1FE3F9BD
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 11:08:26 +0000 (UTC)
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-47f83416551so933768f8f.3
 for <u-boot@lists.u-boot-project.org>; Fri, 31 Jul 2026 04:08:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785496106; x=1786100906;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BAQPL7FwXEM4z5BzgItp/CTWcpbGh3Q6zxe+dDlZ0/I=;
 b=tNTQuyo7nHxWb1GUFgF2Cy71AX6yLvE+wRDnVzwL1A45StiBlbcAn8WAVUlkSr+HFY
 /u7b34Omu+YciUqH0l5szQvxmiBmtaoqAaz2Zzi9lYhb8R7awbNHux1yIFpdJrByk/WX
 XSsRG6pM7xbNoiV12S+7gWTU4v0L+AJyx+rFKq/sQrwZ7ifYCB3lZoGsa+r6BCtRd9s2
 1P8ITxK3h9DbqUJfDsWxUxmAV61DL3IUrW+0vfKa/zSldakH0L81FBe1RHyviXbfenW4
 +maqw+3pkLn4L1Pb75pwU8BwXPmSuNJh0D9e/RO2owVsA1eC7rnHb/WjuylOj5+sdWt/
 WM1w==
X-Forwarded-Encrypted: i=1;
 AHgh+RrKCqbGSEVkzHAUJj/amC/eW05XUbkjE0Bx+Zxk36PZ6hllj365008zZujkB1lmdyus0P5Vnys=@lists.u-boot-project.org
X-Gm-Message-State: AOJu0YwYD9dHPKIMAQVUu/X7AOHKEXAXH2QrJRFl+snXcU0flX5rNHb4
 3Rs7lJvgLrUwD8Cyu6zlp6ru8ltrnjBOti6K4xf25z3LrpUusqHlquRrXu+g9yeltDZA/mzF6gw
 UFwhoD2G2KxaC9eJyroDREoJRlYxYuEwpm/RS1SG9mxtg1IUQbqtgJ0g+MRtoUiq8QUCUGi5vzC
 pPEqhlzaq7xg==
X-Gm-Gg: AR+sD10oCV/ovg6JUZGQs58ruYBoJwaELGwjbNYV+TMlpQqLRD0O59XbIzXDuScagqv
 4aAC76/X4c+aPePWtyBuyXXPomL8TG7lVvBYV3Qoj1tMB2OsqMRRvTlXY17RTTdyHaaxvNPpMjZ
 sdSe2MqvaH/NDOYV++yorzdA7Z6DHigA7WrzU8KNvHrjua2vQnfda6wRwS4ovR1ZflDEB50Bkvy
 Q0wK1oTE1UsphK1cjSR7LQV4RYd3j1ntFfvqSysOEQp0Yh7s6Sr/YJfwsEErjvhnmmpxeM1kaHH
 MK43fSO0uCEGM1SJP/1sAaRY2UzIXQhy7noLuwO9jSEQBwJcKDa7RbRgSfPIVd/JdPsRcm6S7hP
 Laj8Ou2QqwBhjFLrAl+I7Y/OCvGwCjpzV9418gajn8jfs4sOkZVRaRjKkfs+zJ22CA0mm8O+M9Z
 Gi0uX3dhPIw7Ba8PEHC3h3boEl
X-Received: by 2002:a05:6000:41f1:b0:47f:837a:aa1b with SMTP id
 ffacd0b85a97d-47fd2b334cemr3417741f8f.36.1785496106072; 
 Fri, 31 Jul 2026 04:08:26 -0700 (PDT)
X-Received: by 2002:a05:6000:41f1:b0:47f:837a:aa1b with SMTP id
 ffacd0b85a97d-47fd2b334cemr3417686f8f.36.1785496105598; 
 Fri, 31 Jul 2026 04:08:25 -0700 (PDT)
Received: from ?IPV6:2a02:908:1242:30e0:23fb:c22e:a48d:c006?
 ([2a02:908:1242:30e0:23fb:c22e:a48d:c006])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd4562667sm3837495f8f.24.2026.07.31.04.08.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jul 2026 04:08:24 -0700 (PDT)
Message-ID: <215fcf2f-90c5-4a14-b38a-33d2882b0e72@canonical.com>
Date: Fri, 31 Jul 2026 13:08:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] part: efi: use BOOT_PART_TYPE symbol
To: dmukhin@ford.com
Cc: sjg@chromium.org, trini@konsulko.com, u-boot@lists.u-boot-project.org,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Quentin Schulz <quentin.schulz@cherry.de>
References: <20260730013946.1858341-2-dmukhin@ford.com>
Content-Language: en-US
In-Reply-To: <20260730013946.1858341-2-dmukhin@ford.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailman-Original-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=canonical.com; s=20251003; t=1785496106;
 bh=BAQPL7FwXEM4z5BzgItp/CTWcpbGh3Q6zxe+dDlZ0/I=;
 h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
 In-Reply-To:Content-Type;
 b=M2IaLAuSwIBVUxnbWg+nZs1Ofv2N9dEllpNYpeT34v53rjcXGRV3uI69XIRoRGV9y
 3LPb5HtJnlY4wRR7VcYyxVNR0SGOvTlcZ3JZJGK9LJLuXqURuCsnGAgDa37ErOUD79
 rGzTeKlDif+P57G+xGJqdzDpwgK0zn67R25hUmm26OBNNqykIZimsMG4eQg13GZbrI
 NLRmbIVVsEabncZ/2ScfEmiaLWsww65GHgOkl90Lfa0pQeWSX8v1QcgxqdL4cDE7dK
 /CqD0m0SEsIP3j4YPxXi8OOWk1E8R9LAQ2EU69KGTZ21f8A1q4gN5NO+sO86WKrbey
 GL7cHLrfnvNyif4R9KC/3NtG76zhcL0dhnS2LkE/p3lPR2Zg6LH7fOErpSAc5xaHwM
 ys80unlxTJzWbd+iQb51UqoEdBda9/dYqcEWf9XBIIDpNo/Po08PcvvqMoV7BJt2uY
 KjbsbJ1SG36rKyROrnidEljn8nlnyyoDf2FQAL21MgMdmqHYyHWVcYeY8onu5pJtnQ
 EBJoa1oTyFCqyQMpoHE8xbxZke3ezQ7UHRJcJ1Ve7xY1/pU0p58mCvHMqUrG5aHCwf
 o+3RWOuJ2HOMHMgNwGeOM2jNHtsj9VtMOk1EfwJc2RNqCSPfTsLu2M2lpA9+kH3J0s
 ndSSrMHBcIli3nQIGcuG75BA=
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none)
 header.from=canonical.com
X-Mailman-Original-Authentication-Results: smtp4.osuosl.org;
 dkim=pass (4096-bit key,
 unprotected) header.d=canonical.com header.i=@canonical.com
 header.a=rsa-sha256 header.s=20251003 header.b=M2IaLAuS
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
From: Heinrich Schuchardt via U-Boot <u-boot@lists.u-boot-project.org>
Reply-To: Heinrich Schuchardt <heinrich.schuchardt@canonical.com>
Errors-To: u-boot-bounces@lists.u-boot-project.org
Sender: "U-Boot" <u-boot-bounces@lists.u-boot-project.org>

On 7/30/26 03:39, Denis Mukhin via U-Boot wrote:
> From: Denis Mukhin <dmukhin@ford.com>
> 
> Use existing BOOT_PART_TYPE symbol instead of open-coded "U-Boot".
> 
> Signed-off-by: Denis Mukhin <dmukhin@ford.com>
> ---
>   disk/part_efi.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/disk/part_efi.c b/disk/part_efi.c
> index d8b17ec2e91a..1efd2ea113f0 100644
> --- a/disk/part_efi.c
> +++ b/disk/part_efi.c
> @@ -304,7 +304,7 @@ static int __maybe_unused part_get_info_efi(struct blk_desc *desc, int part,
>   
>   	snprintf((char *)info->name, sizeof(info->name), "%s",
>   		 print_efiname(&gpt_pte));
> -	strcpy((char *)info->type, "U-Boot");
> +	strcpy((char *)info->type, BOOT_PART_TYPE);

Thank you for looking into the value of this field which unfortunately 
is not well described in include/part.h. It is used in print_gpt_info() 
to print a user readable description of the partition type.

=> gpt read host 0
Partition 1:
Start 1MiB, size 62MiB
Block size 512, name Linux filesystem
Type U-Boot, bootable 0
UUID d3f19932-f3fb-408a-81dc-fadb4438ed5a
Type GUID c12a7328-f81f-11d2-ba4b-00a0c93ec93b

The constant BOOT_PART_TYPE is unrelated to the field type. It is used 
to define a linker generated list.

The value "U-Boot" itself looks wrong:

For a Mac partition we would expect values like "Apple_HFS", "Apple_Driver".

For an Amiga partition we would see for example "DOS\0", "PDS\0", 
"SFS\0", "LNX\0", "MAC\0", "MDS\0".

For a GPT partition we should have a string representing the partition 
type depending on the partition type GUID.

If CONFIG_PARTITION_TYPE_GUID=y and CONFIG_LIB_UUID=y, we can use 
uuid_guid_get_str() to get the correct value, how about:

diff --git a/disk/part_efi.c b/disk/part_efi.c
index d8b17ec2e91..1385bdae577 100644
--- a/disk/part_efi.c
+++ b/disk/part_efi.c
@@ -304,7 +304,7 @@ static int __maybe_unused part_get_info_efi(struct 
blk_desc *desc, int part,

         snprintf((char *)info->name, sizeof(info->name), "%s",
                  print_efiname(&gpt_pte));
-       strcpy((char *)info->type, "U-Boot");
+       strcpy((char *)info->type, "gpt");
         info->bootable = get_bootable(&gpt_pte);
         info->type_flags = gpt_pte.attributes.fields.type_guid_specific;
         if (CONFIG_IS_ENABLED(PARTITION_UUIDS)) {
@@ -316,6 +316,8 @@ static int __maybe_unused part_get_info_efi(struct 
blk_desc *desc, int part,
                 uuid_bin_to_str(gpt_pte.partition_type_guid.b,
                                 (char *)disk_partition_type_guid(info),
                                 UUID_STR_FORMAT_GUID);
+               snprintf((char *)info->type, sizeof(info->type), "%pUs",
+                        gpt_pte.partition_type_guid.b);
         }

         log_debug("start 0x" LBAF ", size 0x" LBAF ", name %s\n", 
info->start,

test/py/tests/test_gpt.py might need to be adjusted too.

Best regards

Heinrich

>   	info->bootable = get_bootable(&gpt_pte);
>   	info->type_flags = gpt_pte.attributes.fields.type_guid_specific;
>   	if (CONFIG_IS_ENABLED(PARTITION_UUIDS)) {

