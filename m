Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11063CEE330
	for <u-boot@archiver.kernel.org>; Wed,  9 Oct 2024 16:30:10 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 6649A88D1C;
	Wed,  9 Oct 2024 18:30:09 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="XeBVG6tq";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 0018888D1C; Wed,  9 Oct 2024 18:30:07 +0200 (CEST)
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com
 [IPv6:2a00:1450:4864:20::532])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9E47388CBA
 for <u-boot@lists.denx.de>; Wed,  9 Oct 2024 18:30:05 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=jerome.forissier@linaro.org
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5c89f3f28b6so9711042a12.2
 for <u-boot@lists.denx.de>; Wed, 09 Oct 2024 09:30:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728491403; x=1729096203; darn=lists.denx.de;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sukGG/DNd1R67MMjLUqApFuNC7F+ZW7FNO5hdWSwXxU=;
 b=XeBVG6tqSIOGZgbZna7WwxL80+pfHFhJTXcQ+aiGme6uf48Y4lMXcIoQj+PnsIzUwi
 yUBRLlvb8AbmXoZHFLODQUgrfvHdM2rdej2YZVQA8MfDP2jlYGnf6SesdfZjmjMSqwxI
 hO27AWhD2Oa1ALs6eGgulneE0Vcu8fqwA3sUN4khdGvOkigBjjLAA8CRv5wTUWRpv9pV
 uYxPEekWcG8cfdr9XbzoSUNjQiMfJ3Qi+SaCx+o9KhMoCr9bDFilC/x5w11AhGe0/Tmb
 xm3Vc8efDEOih9Dh1oy2fwlRbpsjxcB8ma8RYTgjzQz8ILFDOrwJ8Sltj4dqGSZ7E35F
 oZBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728491403; x=1729096203;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sukGG/DNd1R67MMjLUqApFuNC7F+ZW7FNO5hdWSwXxU=;
 b=dIF1kh38aLCpHJt+lRzLteugvx0MqEJzuWtY06YwPq7cgLoz/FQtEGOZeXO5hsM+rW
 O2QwA3c6OUTHykXLE44eEf0fpmSCLugYgcUMoSr8rXCY9XyoqYScpv0/eF39rK1jcOlq
 nAoxZ3KEQZ4U2pCn4lRMcaIR4CJJ+IlPMK6Fx9V50UdvZOVOZwi1zbEcfa0u7E7K2+UW
 IdTApReyPKBqihJ0zLwxRsgxUkmHcd6IFVai8IEO7MpAuehlelE5hHvhgtp1ehu7sPWD
 dEjiIWTkKaePtMD5Ls46hNs6nZv5C9huK7dYONYvclzpTBHuLMEEfvWHyJn2H4Z5Leli
 EhrA==
X-Gm-Message-State: AOJu0Yx8M9UqjUeBh0AVHpCuxkcxXwrQPKvlra0+TKChtnynk7UU6Kpc
 yJJJaEk6l1KG4F2H7sEmAzom/wKnEi8GIb7RLaM0Kdjg6IUGcdbkuqV5MP1bTx8=
X-Google-Smtp-Source: AGHT+IESHSpWPe+uqHYPFzHgK06GKEJCHUASzYKefgUqBBRYTicmH0WhK4VYFCX5p7zG4ndwi01x4g==
X-Received: by 2002:a05:6402:5215:b0:5c9:1d7f:4fd9 with SMTP id
 4fb4d7f45d1cf-5c91d7f5196mr3054319a12.8.1728491402736; 
 Wed, 09 Oct 2024 09:30:02 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:3363:964:de3b:212f?
 ([2a01:e0a:3cb:7bb0:3363:964:de3b:212f])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c928f1897dsm693546a12.50.2024.10.09.09.29.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2024 09:30:00 -0700 (PDT)
Message-ID: <513c3a74-a33a-4261-899e-30038f8ff878@linaro.org>
Date: Wed, 9 Oct 2024 18:29:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 18/21] net: lwip: tftp: add support of blksize option
 to client
To: Ilias Apalodimas <ilias.apalodimas@linaro.org>
Cc: u-boot@lists.denx.de, Javier Tia <javier.tia@linaro.org>,
 Raymond Mao <raymond.mao@linaro.org>, Maxim Uvarov <muvarov@gmail.com>,
 Tim Harvey <tharvey@gateworks.com>, Anton Antonov <Anton.Antonov@arm.com>,
 Tom Rini <trini@konsulko.com>
References: <cover.1728482473.git.jerome.forissier@linaro.org>
 <6de92bad17c86e300e3ae4d1b8b67569b350410c.1728482473.git.jerome.forissier@linaro.org>
 <CAC_iWj+1xoe2_KtDAnvmXMz7+eAEMAv5CPbuMxWUUefDJa-ofg@mail.gmail.com>
Content-Language: en-US
From: Jerome Forissier <jerome.forissier@linaro.org>
In-Reply-To: <CAC_iWj+1xoe2_KtDAnvmXMz7+eAEMAv5CPbuMxWUUefDJa-ofg@mail.gmail.com>
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



On 10/9/24 17:26, Ilias Apalodimas wrote:
> Hi Jerome,
> 
> On Wed, 9 Oct 2024 at 17:50, Jerome Forissier
> <jerome.forissier@linaro.org> wrote:
>>
>> The TFTP protocol uses a default block size of 512 bytes. This value is
>> sub-optimal for ethernet devices, which have a MTU (Maximum Transmission
>> Unit) of 1500 bytes. When taking into acount the overhead of the IP and
>> UDP layers, this leaves 1468 bytes for the TFTP payload.
>>
>> This patch introduces a new function: tftp_client_set_blksize() which
>> may be used to change the block size from the default. It has to be
>> called after tftp_client_init() and before tftp_get(). If the server
>> does not support the option, the client will still accept to receive
>> 512-byte blocks.
>>
>> Submitted upstream: https://savannah.nongnu.org/patch/index.php?10462
>>
>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>> Acked-by: Ilias Apalodimas <ilias.apalodimas@linaro.org>
>> ---
>>  lib/lwip/lwip/src/apps/tftp/tftp.c            | 94 +++++++++++++++++--
>>  .../lwip/src/include/lwip/apps/tftp_client.h  |  1 +
>>  2 files changed, 89 insertions(+), 6 deletions(-)
>>
>> diff --git a/lib/lwip/lwip/src/apps/tftp/tftp.c b/lib/lwip/lwip/src/apps/tftp/tftp.c
>> index 74fc1fbe586..8e0c071772a 100644
>> --- a/lib/lwip/lwip/src/apps/tftp/tftp.c
>> +++ b/lib/lwip/lwip/src/apps/tftp/tftp.c
>> @@ -57,7 +57,7 @@
>>  #include "lwip/timeouts.h"
>>  #include "lwip/debug.h"
>>
>> -#define TFTP_MAX_PAYLOAD_SIZE 512
>> +#define TFTP_DEFAULT_BLOCK_SIZE 512
>>  #define TFTP_HEADER_LENGTH    4
>>
>>  #define TFTP_RRQ   1
>> @@ -65,6 +65,7 @@
>>  #define TFTP_DATA  3
>>  #define TFTP_ACK   4
>>  #define TFTP_ERROR 5
>> +#define TFTP_OACK  6
>>
>>  enum tftp_error {
>>    TFTP_ERROR_FILE_NOT_FOUND    = 1,
>> @@ -88,9 +89,11 @@ struct tftp_state {
>>    int timer;
>>    int last_pkt;
>>    u16_t blknum;
>> +  u16_t blksize;
>>    u8_t retries;
>>    u8_t mode_write;
>>    u8_t tftp_mode;
>> +  bool wait_oack;
>>  };
>>
>>  static struct tftp_state tftp_state;
>> @@ -137,10 +140,24 @@ send_request(const ip_addr_t *addr, u16_t port, u16_t opcode, const char* fname,
>>  {
>>    size_t fname_length = strlen(fname)+1;
>>    size_t mode_length = strlen(mode)+1;
>> -  struct pbuf* p = init_packet(opcode, 0, fname_length + mode_length - 2);
>> +  size_t blksize_length = 0;
>> +  struct pbuf* p;
>>    char* payload;
>>    err_t ret;
>>
>> +  if (tftp_state.blksize) {
>> +    blksize_length = 14; /* maximum (blksize is a u16_t): 'blksize\0XXXXX\0' */
>> +    if (tftp_state.blksize < 10000)
>> +           blksize_length--;
>> +    if (tftp_state.blksize < 1000)
>> +           blksize_length--;
>> +    if (tftp_state.blksize < 100)
>> +           blksize_length--;
>> +    if (tftp_state.blksize < 10)
>> +           blksize_length--;
>> +  }
> 
> I'd really prefer the alternative for this [0]. Since you havent
> changed it, make sure you queue it up if v12 gets merged

Sorry about that, I forgot. The code you propose in [0] needs a few
adjustments: >= not >, initialize cnt to 1 to account for one digit at
least, and do nothing if tftp_state.blksize == 0. We can get rid of
cnt and it still looks good and even better IMO. So how about this?

diff --git a/lib/lwip/lwip/src/apps/tftp/tftp.c b/lib/lwip/lwip/src/apps/tftp/tftp.c
index 8e0c071772a..7012aad9d91 100644
--- a/lib/lwip/lwip/src/apps/tftp/tftp.c
+++ b/lib/lwip/lwip/src/apps/tftp/tftp.c
@@ -141,20 +141,18 @@ send_request(const ip_addr_t *addr, u16_t port, u16_t opcode, const char* fname,
   size_t fname_length = strlen(fname)+1;
   size_t mode_length = strlen(mode)+1;
   size_t blksize_length = 0;
+  int blksize = tftp_state.blksize;
   struct pbuf* p;
   char* payload;
   err_t ret;
 
-  if (tftp_state.blksize) {
-    blksize_length = 14; /* maximum (blksize is a u16_t): 'blksize\0XXXXX\0' */
-    if (tftp_state.blksize < 10000)
-	    blksize_length--;
-    if (tftp_state.blksize < 1000)
-	    blksize_length--;
-    if (tftp_state.blksize < 100)
-	    blksize_length--;
-    if (tftp_state.blksize < 10)
-	    blksize_length--;
+  if (blksize) {
+    /* "blksize\0.\0" with . = 1 digit */
+    blksize_length = strlen("blksize") + 1 + 1 + 1;
+    while (blksize >= 10) {
+      blksize /= 10;
+      blksize_length++;
+    }

> 
>> +
>> +  p = init_packet(opcode, 0, fname_length + mode_length + blksize_length - 2);
>>    if (p == NULL) {
>>      return ERR_MEM;
> 
> [...]
> 
>>
>>
>> --
>> 2.40.1
>>
> 
> [0] https://lore.kernel.org/u-boot/CAC_iWjJjsOZYZHB+019G8xs33+Bj2FeV8MB7FfhJ-C8v8uBNng@mail.gmail.com/
> 
> Thanks
> /Ilias

Thanks,
-- 
Jerome
