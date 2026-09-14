Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C1D0C88E72
	for <u-boot@archiver.kernel.org>; Mon, 14 Sep 2026 23:16:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 13BB7605F7;
	Mon, 14 Sep 2026 23:16:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 8sKAKlYpof7E; Mon, 14 Sep 2026 23:16:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp3.osuosl.org 78069605EF
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1789427775;
	b=YHdjxXpymn5X9MEHUbZYUMDwvF6YNF0FC7CKfy0yLz7YH3XhXEJKvgPPFured1mZdRTT
	 5nLVMwc7EwmePrgmFYy8NzIEdJMLCWKFyoJnDOjptA2lPS9ZxzEavq3c9AiYInJboPXYV
	 /b15eLyXgChY0A22H2M7IdznRaGSbmDdLDmLIFFBZCWtbUPUBf19FXRyp1NCCzcL6IALG
	 eI8MC3qRNzkR61vodY2jYBcDvOIGWtRbrTYmtxv/zI32L25cgTDJYk2sh9H6GRWFfenRL
	 Xc8xwTFN37h1Dhn3vNj/pOLh3HVNKxuOt+Bl8O/zbl+5jZRkClejnaDxUcYh2uAstkA==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1789427775;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:From:To:In-Reply-To:References:Subject:Message-Id:
	 Date:MIME-Version:Content-Type:Content-Transfer-Encoding:X-Mailer:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Errors-To;
	bh=LHfIIWSf8PbmORejcJ6WOPcG6BsG8ouophb/leUC/+8=;
	b=cPUpUbd6sjo82NjS4sTZT2ufwI6ldLWnvjzyR54LReozeEuqsSpENJR9bARAx41ej9D+
	 binW22hbGVZhHAfUkAMoGLonKmgksq0zsUMKLSn+hOWwLdi58HmDmhRDnnxpLmmjg3oeM
	 Q8EZSib58iJybBvkpzjyVUNKaoPP9CSRIQExDKig6mw9uVrZ+0GWvW89zk9YpbSwkrUHS
	 P3iRsUJH3bP5HrapRqC+lZBkbLk0c6Aw/JUJDAPHNfoGmqlCChawOk4Yi+gQSwy6r3DCd
	 6GXLdBYt+06mZoCDUZjA1KuYBIJ7AT//uN2PMnqrKL66DgfFS/i2HS3M4CTQ/Iznz8Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1789427775;
	bh=LHfIIWSf8PbmORejcJ6WOPcG6BsG8ouophb/leUC/+8=;
	h=From:To:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=CgTc8dCsvak05i0HIgF9Ka/6lAcSP5SQMrSL1kGKwwMwDFGEhVgVha8HeKGHl/w93
	 YDP1q0n4zsh7aghofbIKcmfTNpEsOO2cG62PawCuwWkkLNJFwPacDNdXwsYqxEPBrt
	 n08nOzHehL1wKP0C9IVKZ8esI4Ojotg1nIbW3NUZeSBoCHVIhTQAoukokpZUwi2Rni
	 2AzSQAoz9CocmFD0LfTQ0J8+BPXvXz2oiEF/E79gmaRzeeZPa0UGuf1gZWJC/4Wfhx
	 cgZIjHW600R8OqP/FzlZioQPvHgvpf9PbB8xlwsFov2spQhtHimKKCcLlU+uX5qlcf
	 Ecus1Zl1Rj5rw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id 78069605EF;
	Mon, 14 Sep 2026 23:16:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id A43AD224
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 23:16:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8A8824054A
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 23:16:11 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id z8gusTvBmZnL for <u-boot@lists.u-boot-project.org>;
 Mon, 14 Sep 2026 23:16:11 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org E08D3404F8
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::230"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1789427771;
 b=BPQX0lhvcLB7/lSpRjdZWyUHvv60G7eoGp5SRtswarxDaR9RFiVQbadgngtuUKDm2C98
 gc0W8SQ0UcpbZ4IewTtih20iSMUg5CnVzItfDYP0gxFZbCv9Fe06x5DAoHJmS5LTKZr2n
 /z/StIpHy0iL1x5mCWtiXO+/WVk1dbnRcDn9RFCja8k0ba2S/LahvrSv6gHkqjSmhmU7D
 EHYWuT7uf6sssH0yE3Y9iy5xMDR+lrlhKxfwTG3ZY5kE73LMol2qCyLmS5XHkPAV+kUfp
 DBmWuaB0eeLvVXgm+fku8VjX4tIen32r3U20UvquQgITUDhg+T35DY2kzBDUZqelREA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1789427771;
 h=Received-SPF:Received:DKIM-Signature:X-Google-DKIM-Signature:
 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:In-Reply-To:
 References:Subject:Message-Id:Date:MIME-Version:Content-Type:
 Content-Transfer-Encoding:X-Mailer;
 bh=LHfIIWSf8PbmORejcJ6WOPcG6BsG8ouophb/leUC/+8=;
 b=U+gffSWkGF7THbMusC0RyT4VI2R2q1KNi5i19LDPWJswNctp9ta2PdSjGJFwp0K5ohR9
 lthoxpMvrJp8fMaLRrjqtYu5WzwtY4KFrirETpumaYWcrWy1JbuL5zX70a9yhgjhWloHM
 azLLCubsKjfH8T0WXnHKI68jwjhTmwo0gJwMVAIFSESFbbzu3ajyklD+KuFq16AjbbvH0
 zPr/aIblz88sbBc6qqXszCY8hgyYK8DN/ZSzhhMGki3B78ItWw3HxwXU/1LxoHymbixv9
 qR6kgIv02jw6+UkQAUL5IVPybTOCZPjNcEf+uAfk83XbqHNknRpUxZdEftEBk3yPAww==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=konsulko.com; 
 dkim=pass header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Nf+6vNv4; 
 arc=none smtp.remote-ip="2607:f8b0:4864:20::230"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::230; helo=mail-oi1-x230.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp4.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=Nf+6vNv4
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com
 [IPv6:2607:f8b0:4864:20::230])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E08D3404F8
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 23:16:10 +0000 (UTC)
Received: by mail-oi1-x230.google.com with SMTP id
 5614622812f47-4b381337e1fso4045569b6e.1
 for <u-boot@lists.u-boot-project.org>; Mon, 14 Sep 2026 16:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1789427769; x=1790032569;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LHfIIWSf8PbmORejcJ6WOPcG6BsG8ouophb/leUC/+8=;
 b=Nf+6vNv4kGeuZlJW3vK2WroyCTKsid+S1+BME3w+IE1m5PCngmQvzud+PfRdWHgs34
 nVfuNsXWI7TjAUjI/bAzMtoBetF/qLWlLTk3xhThyjjcnlU0Vy5kFg/ohbKDnxSj6uYV
 dHYT6MsrP4EW2zCVKCW+rmINjcCf9O2Gld3wM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789427769; x=1790032569;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:to:from:x-gm-gg:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LHfIIWSf8PbmORejcJ6WOPcG6BsG8ouophb/leUC/+8=;
 b=mMqz3Gb+nhkRcqFZM7jGSLuXnQ2qJqZXMDkw0QlFzbVaQlVkkX+KBJrxHG+NOrrmR0
 zujsD8g/d0bHzDpP9iHQ0aJLxjbMx/qNFsfFKkJ1Tv85A+trQe6dJYG9pjvFzGbcAX0f
 +d+CqZ7W80fpiLg4u0xoXt791/ikxW9G+po20t8ybOSw6wAzq5gzRSs2nLEIOLZcOoJh
 zCXwQRYGvzDJOXXxUjMYwbncQcy8r+PI1HuP0W6Re2aMSXK+pxB3sdM0anFdNV7mJqvd
 1ah7nQYpocpIrkz4uBuNWfbiTgddLIQs7nb5eo6m/ixYB8boZ0cY3N7zi1bVZitnLfiB
 HmXg==
X-Gm-Message-State: AFuF++mPIFIhM2+xyVqJMLprbqBQJtj4cE9Cv6Te0Ojf0sN0CdbIqjTs
 5dYIPWA58v1euHScedlciYxDroETcNWcUQjhOLm9qFKuFeLae68MA0Xz+sYg4W1E6Hs=
X-Gm-Gg: AYBFou3XyKEFjlr0vcV9jEo7Eqbw5oYFpeeyOYGW5iaJFe0p2h3Ke6xhehavPd/Hqly
 tjWurN6Vwn7JnSqdYeVJakg1AszJKkvWDQObYbP3oOipyZW08u+k5bAei7b6Dvxgyr0om7KdxDX
 SZf+Y5glY9OuhVBTr4gCpdatE7L3LZ4hspO59MlnMvh4QCxTYg+ZHYx6PsJ7TmmRnmZz2cgyyuC
 fqFedKOWWVUWZEyCJhKnUbPvWQZiENemy/JgTzM7Zu1z+1AA5/cKW0ad6wYAxSG/vPU+tEPl4l5
 /SJYwLGnuiPZxIGL6QRudVcfaz3yOHMkTtQsu1aKrYqi/71aOL40XsCbx9W4c2HxIs9bRHw9NCo
 Ll1qAck1PSDbIN902MyysKOvX9M2mrArHehHWbVrVe73WVAD/d5WecgRLs3MDbi6O4Wsy8yk/la
 /AOcLXBufSWtEfKigoRiPHz2q9Eijr94FP0PcAHrv9NmnK4PnFUCEK9CaJY31NbQcDAC41DwrR7
 JRnQPcEawDJgHAmgUSOYtt/GFL+EY9sbZmqTZrx9JYWcBw2pKdxoDOD4pU5DHL/mo5l81G2QQIz
 wLcxl0Rb83wrOs9xwvaDGBIPEI2p9w==
X-Received: by 2002:a05:6808:4f29:b0:4bc:d58d:6cff with SMTP id
 5614622812f47-4c7b539dbc0mr3814118b6e.43.1789427769617; 
 Mon, 14 Sep 2026 16:16:09 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4c3314b17d0sm11811299b6e.8.2026.09.14.16.16.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Sep 2026 16:16:09 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: u-boot@lists.u-boot-project.org, 
 Wagner Popov dos Santos <wpopov@gmail.com>
In-Reply-To: <20260826131030.1372296-1-wpopov@gmail.com>
References: <20260826131030.1372296-1-wpopov@gmail.com>
Subject: Re: [PATCH] jffs2: initialize datacrc for inode/dirent entries
 built from scan
Message-Id: <178942776854.665895.14638555076499943347.b4-ty@konsulko.com>
Date: Mon, 14 Sep 2026 17:16:08 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
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

On Wed, 26 Aug 2026 10:10:30 -0300, Wagner Popov dos Santos wrote:

> jffs2_1pass_build_lists() initializes inode and dirent list entries from
> raw node scanning, but leaves b->datacrc uninitialized in both paths.
> 
> Later, jffs2_1pass_read_inode() uses b->datacrc to decide whether to
> compute and validate the node data CRC, or to discard the entry as
> CRC_BAD. With an undefined value, behavior is non-deterministic:
> entries may be incorrectly dropped or CRC verification may be skipped.
> 
> [...]

Applied to u-boot/next, thanks!

[1/1] jffs2: initialize datacrc for inode/dirent entries built from scan
      commit: 7ac3028f4796114786909f486c5d276937b793dd
-- 
Tom


