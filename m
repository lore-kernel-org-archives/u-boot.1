Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D404CC47258
	for <u-boot@archiver.kernel.org>; Wed, 31 Jan 2024 07:11:59 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 51F54879B5;
	Wed, 31 Jan 2024 08:11:58 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="lRKxOR0o";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id F239A8798B; Wed, 31 Jan 2024 08:11:56 +0100 (CET)
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com
 [IPv6:2a00:1450:4864:20::333])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3329187B75
 for <u-boot@lists.denx.de>; Wed, 31 Jan 2024 08:11:53 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=dan.carpenter@linaro.org
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-40e7065b7bdso53543725e9.3
 for <u-boot@lists.denx.de>; Tue, 30 Jan 2024 23:11:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706685112; x=1707289912; darn=lists.denx.de;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=QstXt9nCBvOOIyZSzTJZ4xqkeKrXcNFFHGO2Him+cJk=;
 b=lRKxOR0ofTfZmbvcruQi03kndyqfuivWiwp3C+Vk6oJHGVtttF2rfFRHh4Atoke4Xb
 990PtdrRqY2mAzCodESK+0axq0VY3BiPx87RU0HjPAUgqYtnR7+CicyzirVh9PIgxrpC
 BvLChjk/5F/QKyL88i1vVg4EVHw3tKjUcdVKWd08eoyv6BdYdw3oRXDYi+vjxjkzaMaW
 dDtFtsvkRK9LvZjEcZmk6wQUMMPts0PTdC+h5U+fz0bXWjVESbIzHxA4ge1fwOLnkpU7
 Bcc7L5vBh5hLXoFGjaWBHfX8UFukcVtq71sLOjCq3TclaGiMPcSinRme5jF2Abb1Sn9I
 fLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706685112; x=1707289912;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=QstXt9nCBvOOIyZSzTJZ4xqkeKrXcNFFHGO2Him+cJk=;
 b=Y1ozUcbjZRKzk6PdcO4Fl2e559PtR1RLpNi+JkErtiyn+DVAQ7V6EKrdri0VO9Rtc/
 MkNMaNcChZpVEOk74OLY7kqkqvzQ0/JmGZDPFzWzUJqLrUQ3E8+eUqGSKi/pOkvIsuii
 308vFuwfqT0Y6ktYPp2EbjpFNfcjFAijIhYl9YfT74At91naF5XgCpselUajGuqRE/IR
 BS1GFeGLcihe1OTvHGfH7iZmfFtGdvNBLtR3Wqq7ahgp8yTqEUm0mcW4yXdKaUP5p08/
 MxtmITs++2XBp2XFR3SqGjoiCSAIL/6BP9GUOs/EFtzRezkqMEXIgSoWX7hwqsTdrrzr
 OvdQ==
X-Gm-Message-State: AOJu0YxuZj0IdNa/IAFLyNoF64fhI64IbGDwmV4jswJ6plnBSkLZXX9g
 9KqcSzyFYF+1mYPhQrfna5wUHPmqCguJZuffMjBSZc4F944H0MLWM6w27q7D99s1idI4LkOfngd
 m
X-Google-Smtp-Source: AGHT+IEZ8U93VPiZJoacEiEi4e3mTdCoHGheliT3XW7rlgenCJMD6ArYTgrkWHx5ybecGulIagCeXA==
X-Received: by 2002:a05:600c:46c6:b0:40f:afb3:97d5 with SMTP id
 q6-20020a05600c46c600b0040fafb397d5mr581794wmo.38.1706685112641; 
 Tue, 30 Jan 2024 23:11:52 -0800 (PST)
Received: from localhost ([102.140.226.10]) by smtp.gmail.com with ESMTPSA id
 m4-20020a5d6244000000b0033ae4a3b285sm10220644wrv.36.2024.01.30.23.11.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 23:11:52 -0800 (PST)
Date: Wed, 31 Jan 2024 10:11:49 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: qianfanguijin@163.com
Cc: u-boot@lists.denx.de
Subject: [bug report] lib: sparse: Make CHUNK_TYPE_RAW buffer aligned
Message-ID: <1b323ec3-59b0-490b-a2f0-fd961dafcf49@moroto.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
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

Hello qianfan Zhao,

The patch 62649165cb02: "lib: sparse: Make CHUNK_TYPE_RAW buffer
aligned" from Nov 16, 2021, leads to the following Smatch static
checker warning:

	lib/image-sparse.c:214 write_sparse_image()
	warn: unsigned 'blks' is never less than zero.

lib/image-sparse.c
    109 int write_sparse_image(struct sparse_storage *info,
    110                        const char *part_name, void *data, char *response)
    111 {
    112         lbaint_t blk;
    113         lbaint_t blkcnt;
    114         lbaint_t blks;
                ^^^^^^^^^^^^^
This is a u64


    115         uint64_t bytes_written = 0;
    116         unsigned int chunk;
    117         unsigned int offset;
    118         uint64_t chunk_data_sz;
    119         uint32_t *fill_buf = NULL;
    120         uint32_t fill_val;
    121         sparse_header_t *sparse_header;
    122         chunk_header_t *chunk_header;
    123         uint32_t total_blocks = 0;
    124         int fill_buf_num_blks;
    125         int i;
    126         int j;
    127 
    128         fill_buf_num_blks = CONFIG_IMAGE_SPARSE_FILLBUF_SIZE / info->blksz;

[ snip ]

    211 
    212                         blks = write_sparse_chunk_raw(info, blk, blkcnt,
    213                                                       data, response);
--> 214                         if (blks < 0)
                                    ^^^^^^^^
Can't be less than zero

    215                                 return -1;
    216 
    217                         blk += blks;
    218                         bytes_written += ((u64)blkcnt) * info->blksz;
    219                         total_blocks += chunk_header->chunk_sz;
    220                         data += chunk_data_sz;
    221                         break;
    222 
    223                 case CHUNK_TYPE_FILL:
    224                         if (chunk_header->total_sz !=

regards,
dan carpenter
