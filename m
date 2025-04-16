Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE78C369BD
	for <u-boot@archiver.kernel.org>; Wed, 16 Apr 2025 11:14:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C675282D17;
	Wed, 16 Apr 2025 13:14:57 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="jN1PYFW/";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id ECFC882D40; Wed, 16 Apr 2025 13:14:56 +0200 (CEST)
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com
 [IPv6:2a00:1450:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id B272A82CF6
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 13:14:54 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-39141ffa9fcso8603779f8f.0
 for <u-boot@lists.denx.de>; Wed, 16 Apr 2025 04:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744802094; x=1745406894; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qCLSd3KFZ2+MYAXJT4mS9xuyI4HxFSx/LNWZg/pqkhs=;
 b=jN1PYFW/OAop5+j9czEDGxh9mvs0RqfSV5tEJBaegoQSH9IPeXOAuKCRf7vp91xwGu
 YyPTOhLSX/H5zICoNVsz/e7/CoKW43eNecL83U14dTVJkmVDb668ufvpQkI/qfvYjG2q
 EmNu5mnjuN847BLlkIAZAmiHUsOe8AxA2SFzwQ7tA3yBmsls4/eafHBsojCkQHeeRXFx
 3aBPEfFjPOilIZy1nH5LUumwdDJd0y8y2H/u6rn/969c5JMyz9gzrrY8Gmj+Is+cUAYo
 0ybMdDbdfKDwjzdNoSNFBEu2YuCsFCrGK8PKScUhDhVTvfgA05JwMZMhSLVFQZibaF5a
 d0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744802094; x=1745406894;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qCLSd3KFZ2+MYAXJT4mS9xuyI4HxFSx/LNWZg/pqkhs=;
 b=jQzEH1RQ1LDO1WQqggQGCD/30NnDZBbqwiHxGA8zxgtjAHxm1Z29vHwoVqnW43WVB7
 T2u6fX7DKFvqwipFSVBIXzNuFm5iuZ7XrDBGUNCQUfQM3cUOxK0hk/ULy+haT9fnLoCX
 AgNxLBJsXiOV/4O3HEKZOnYoju3SqpevZhlQ1U+lUhJg5WavDTfTzDv/7E6ABcI3kQLO
 /rBM+7x+8679vIisJUQYWZZO076OdWiKFpT2e4aBip4a2GLl43i5zN1isgFl0+yj22Wa
 5YqleohACodd0rWnWyUouzq0M6sd3zOUmT6tHkDtqUo92j6SFtoL6ppatSxv4a7qbABJ
 gvkQ==
X-Gm-Message-State: AOJu0YxBmJL6Od0ZOQzjrNw/p+JlUzYaPTqNEd1MkTURB53v6pxzl3xd
 yuLi/su2apFH/itXchoo4N/Asz8mrSvP3LM64y+8smnlSTPgSjS5qgOJvTY0yfU=
X-Gm-Gg: ASbGnctJNKV3YEnLVTIP/ub+Y0hh0N2CiXFTp4EEd28kwrH/thlyWUSBNSBrdd0JqZZ
 AdyhCgLfERJVw5QGGG6wb2wK0svzKl9DfkdTBXFEhSG/UKz9k8B4zhGyYiax3pF+LH05GCWbZXw
 UaXrIq53Qw3bOnIAPKzKjuJQsqD8LqH5TvfegJVAAdbxH5b4xydcea+Z6UFpXcoPuM2fES3BwoE
 kRStLyrNHE5tuNkZ/Bgg9/0Hnq80/jDKWweuQKC+d9x22wua1gHl/BFB1a2mAeXdFt1KLTZ+eGV
 GuVhmLGJXjlNyKGhJU0tpu46WD5aDFHjksJ8HDM2XNeCY+bJqdaPOfjIePOYEvCuBeZwOdQcGJA
 B83NRYCY1Grhf/KWdkzVnw64gfOpYT6k=
X-Google-Smtp-Source: AGHT+IHDlSjewwc/wTuWQBkI5WWoPPP16o4gxV8x4BVEp92lykmYj1rtYjDpySayrEQeW9tpI2vyKA==
X-Received: by 2002:a05:6000:18a7:b0:39c:2c38:4599 with SMTP id
 ffacd0b85a97d-39ee5b9ee51mr1408642f8f.48.1744802094035; 
 Wed, 16 Apr 2025 04:14:54 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:7ea6:fc42:6067:58c9?
 ([2a01:e0a:3cb:7bb0:7ea6:fc42:6067:58c9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39eae96c684sm17003024f8f.33.2025.04.16.04.14.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 16 Apr 2025 04:14:53 -0700 (PDT)
Message-ID: <f301a354-8691-457b-a5b4-bd295f8ecfee@linaro.org>
Date: Wed, 16 Apr 2025 13:14:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/4] net, net-lwip: wget: suppress console output when
 called by EFI
To: Sughosh Ganu <sughosh.ganu@linaro.org>
Cc: U-Boot mailing list <u-boot@lists.denx.de>,
 Heinrich Schuchardt <xypron.glpk@gmx.de>,
 Adriano Cordova <adrianox@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Joe Hershberger <joe.hershberger@ni.com>,
 Mikhail Kshevetskiy <mikhail.kshevetskiy@iopsys.eu>,
 Ramon Fried <rfried.dev@gmail.com>, Simon Glass <sjg@chromium.org>,
 Tom Rini <trini@konsulko.com>
References: <20250415193436.1240804-1-jerome.forissier@linaro.org>
 <20250415193436.1240804-3-jerome.forissier@linaro.org>
 <CADg8p94L3tNj=FbBHn8h2DetWd7qeKPRMMbS0c4y6ccCaDm70g@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CADg8p94L3tNj=FbBHn8h2DetWd7qeKPRMMbS0c4y6ccCaDm70g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
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

Hi Sughosh,

On 4/16/25 12:22, Sughosh Ganu wrote:
> On Wed, 16 Apr 2025 at 01:04, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>> Functions called from EFI applications should not do console output.
>> Refactor the wget code to implement this requirement. The wget_http_info
>> struct is used to hold the boolean that signifies whether the output is
>> allowed or not.
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> Reported-by: Heinrich Schuchardt <xypron.glpk@gmx.de>
>> ---
>>
>> Changes in v4:
>> - Patch renamed, deals with NET in addition to NET_LWIP
>>
>> Changes in v3:
>> - New patch
>>
>>  include/net-common.h     |  2 ++
>>  lib/efi_loader/efi_net.c |  2 +-
>>  net/lwip/wget.c          | 33 +++++++++++++++++++++++----------
>>  net/wget.c               | 23 +++++++++++++++++------
>>  4 files changed, 43 insertions(+), 17 deletions(-)
>>
>> diff --git a/include/net-common.h b/include/net-common.h
>> index 30860f5975a..1043b24d0b9 100644
>> --- a/include/net-common.h
>> +++ b/include/net-common.h
>> @@ -555,6 +555,7 @@ enum wget_http_method {
>>   *                     Filled by client.
>>   * @hdr_cont_len:      content length according to headers. Filled by wget
>>   * @headers:           buffer for headers. Filled by wget.
>> + * @silent:            do not print anything to the console. Filled by client.
>>   */
>>  struct wget_http_info {
>>         enum wget_http_method method;
>> @@ -565,6 +566,7 @@ struct wget_http_info {
>>         bool check_buffer_size;
>>         u32 hdr_cont_len;
>>         char *headers;
>> +       bool silent;
>>  };
>>
>>  extern struct wget_http_info default_wget_info;
>> diff --git a/lib/efi_loader/efi_net.c b/lib/efi_loader/efi_net.c
>> index b3291b4f1d5..9ff0b691ee1 100644
>> --- a/lib/efi_loader/efi_net.c
>> +++ b/lib/efi_loader/efi_net.c
>> @@ -51,7 +51,7 @@ static int next_dp_entry;
>>  static struct wget_http_info efi_wget_info = {
>>         .set_bootdev = false,
>>         .check_buffer_size = true,
>> -
>> +       .silent = true,
>>  };
>>  #endif
>>
>> diff --git a/net/lwip/wget.c b/net/lwip/wget.c
>> index 2b512a1bc84..3529768eb06 100644
>> --- a/net/lwip/wget.c
>> +++ b/net/lwip/wget.c
>> @@ -217,7 +217,8 @@ static err_t httpc_recv_cb(void *arg, struct altcp_pcb *pcb, struct pbuf *pbuf,
>>                 memcpy((void *)ctx->daddr, buf->payload, buf->len);
>>                 ctx->daddr += buf->len;
>>                 ctx->size += buf->len;
>> -               if (ctx->size - ctx->prevsize > PROGRESS_PRINT_STEP_BYTES) {
>> +               if (!wget_info->silent &&
>> +                   ctx->size - ctx->prevsize > PROGRESS_PRINT_STEP_BYTES) {
>>                         printf("#");
>>                         ctx->prevsize = ctx->size;
>>                 }
>> @@ -255,11 +256,15 @@ static void httpc_result_cb(void *arg, httpc_result_t httpc_result,
>>         elapsed = get_timer(ctx->start_time);
>>         if (!elapsed)
>>                 elapsed = 1;
>> -       if (rx_content_len > PROGRESS_PRINT_STEP_BYTES)
>> -               printf("\n");
>> -       printf("%u bytes transferred in %lu ms (", rx_content_len, elapsed);
>> -       print_size(rx_content_len / elapsed * 1000, "/s)\n");
>> -       printf("Bytes transferred = %lu (%lx hex)\n", ctx->size, ctx->size);
>> +       if (!wget_info->silent) {
>> +               if (rx_content_len > PROGRESS_PRINT_STEP_BYTES)
>> +                       printf("\n");
>> +               printf("%u bytes transferred in %lu ms (", rx_content_len,
>> +                      elapsed);
>> +               print_size(rx_content_len / elapsed * 1000, "/s)\n");
>> +               printf("Bytes transferred = %lu (%lx hex)\n", ctx->size,
>> +                      ctx->size);
>> +       }
>>         if (wget_info->set_bootdev)
>>                 efi_set_bootdev("Http", ctx->server_name, ctx->path, map_sysmem(ctx->saved_daddr, 0),
>>                                 rx_content_len);
>> @@ -339,7 +344,8 @@ static int _set_cacert(const void *addr, size_t sz)
>>         mbedtls_x509_crt_init(&crt);
>>         ret = mbedtls_x509_crt_parse(&crt, cacert, cacert_size);
>>         if (ret) {
>> -               printf("Could not parse certificates (%d)\n", ret);
>> +               if (!wget_info->silent)
>> +                       printf("Could not parse certificates (%d)\n", ret);
>>                 free(cacert);
>>                 cacert = NULL;
>>                 cacert_size = 0;
>> @@ -392,6 +398,12 @@ int wget_do_request(ulong dst_addr, char *uri)
>>         ctx.prevsize = 0;
>>         ctx.start_time = 0;
>>
>> +       if (!wget_info)
>> +               wget_info = &default_wget_info;
>> +
>> +       net_lwip_set_current();
>> +       udev = eth_get_dev();
>> +
> 
> Wasn't this already done in the first patch? Looks like this hunk is
> superfluous. Apart from that, it looks fine to me. Thanks for taking
> up this change.

Indeed, I messed up when rebasing. I'll remove this hunk.

Thank you,
-- 
Jerome

> 
> -sughosh
> 
>>         if (parse_url(uri, ctx.server_name, &ctx.port, &path, &is_https))
>>                 return CMD_RET_USAGE;
>>
>> @@ -421,9 +433,10 @@ int wget_do_request(ulong dst_addr, char *uri)
>>
>>                 if (cacert_auth_mode == AUTH_REQUIRED) {
>>                         if (!ca || !ca_sz) {
>> -                               printf("Error: cacert authentication mode is "
>> -                                      "'required' but no CA certificates "
>> -                                      "given\n");
>> +                               if (!wget_info->silent)
>> +                                       printf("Error: cacert authentication "
>> +                                              "mode is 'required' but no CA "
>> +                                              "certificates given\n");
>>                                 return CMD_RET_FAILURE;
>>                        }
>>                 } else if (cacert_auth_mode == AUTH_NONE) {
>> diff --git a/net/wget.c b/net/wget.c
>> index c73836cbc9d..3c0fff488eb 100644
>> --- a/net/wget.c
>> +++ b/net/wget.c
>> @@ -59,8 +59,10 @@ static inline int store_block(uchar *src, unsigned int offset, unsigned int len)
>>         if (CONFIG_IS_ENABLED(LMB) && wget_info->set_bootdev) {
>>                 if (store_addr < image_load_addr ||
>>                     lmb_read_check(store_addr, len)) {
>> -                       printf("\nwget error: ");
>> -                       printf("trying to overwrite reserved memory...\n");
>> +                       if (!wget_info->silent) {
>> +                               printf("\nwget error: ");
>> +                               printf("trying to overwrite reserved memory\n");
>> +                       }
>>                         return -1;
>>                 }
>>         }
>> @@ -76,6 +78,9 @@ static void show_block_marker(u32 packets)
>>  {
>>         int cnt;
>>
>> +       if (wget_info->silent)
>> +               return;
>> +
>>         if (content_length != -1) {
>>                 if (net_boot_file_size > content_length)
>>                         content_length = net_boot_file_size;
>> @@ -101,11 +106,15 @@ static void tcp_stream_on_closed(struct tcp_stream *tcp)
>>         net_set_state(wget_loop_state);
>>         if (wget_loop_state != NETLOOP_SUCCESS) {
>>                 net_boot_file_size = 0;
>> -               printf("\nwget: Transfer Fail, TCP status - %d\n", tcp->status);
>> +               if (!wget_info->silent)
>> +                       printf("\nwget: Transfer Fail, TCP status - %d\n",
>> +                              tcp->status);
>>                 return;
>>         }
>>
>> -       printf("\nPackets received %d, Transfer Successful\n", tcp->rx_packets);
>> +       if (!wget_info->silent)
>> +               printf("\nPackets received %d, Transfer Successful\n",
>> +                      tcp->rx_packets);
>>         wget_info->file_size = net_boot_file_size;
>>         if (wget_info->method == WGET_HTTP_METHOD_GET && wget_info->set_bootdev) {
>>                 efi_set_bootdev("Http", NULL, image_url,
>> @@ -139,7 +148,8 @@ static void tcp_stream_on_rcv_nxt_update(struct tcp_stream *tcp, u32 rx_bytes)
>>                     tcp->state == TCP_ESTABLISHED)
>>                         goto end;
>>
>> -               printf("ERROR: misssed HTTP header\n");
>> +               if (!wget_info->silent)
>> +                       printf("ERROR: misssed HTTP header\n");
>>                 tcp_stream_close(tcp);
>>                 goto end;
>>         }
>> @@ -346,7 +356,8 @@ void wget_start(void)
>>         tcp_stream_set_on_create_handler(tcp_stream_on_create);
>>         tcp = tcp_stream_connect(web_server_ip, server_port);
>>         if (!tcp) {
>> -               printf("No free tcp streams\n");
>> +               if (!wget_info->silent)
>> +                       printf("No free tcp streams\n");
>>                 net_set_state(NETLOOP_FAIL);
>>                 return;
>>         }
>> --
>> 2.43.0
>>
