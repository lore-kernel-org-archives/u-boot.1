Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 409B4C5DF85
	for <u-boot@archiver.kernel.org>; Thu, 20 Aug 2026 18:55:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 039F480AE6;
	Thu, 20 Aug 2026 18:55:50 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vbLBlYSQEGAY; Thu, 20 Aug 2026 18:55:49 +0000 (UTC)
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1787252149;
	bh=BKAmxBcUWmXXHnDn/5AhTaRfYWaR2FujYK0OBgwxcJ0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=SIT/GeLKdi4VrrtEgCvpwMd/toY6pTN+NxPKZSfPfdAe89m84ZCJhlB4T7qV30AZ8
	 3s3wAhTUUaArAqwtsH86Sn1z385bJyCIkwzraD9eGpFLFeiydlTjvHPVBjgRFcpH4e
	 /UWiQJxAWdsS80uihBftBI2ntc3SVCclKB1ROmUjfjxHtOxjXqc9n9QmYSezgziJTK
	 qNdYjdL8/xBql3yyOmXJ2DIJOm1owVePgRS62GSyqzBgtHvpSAJL08ZK1Kg4PbKzD2
	 69GPSHR1GPz27wsjo8wEpiBitG480x3Wi6CjMwlVU3Zil+86albNbuNUXk4/qdSb8z
	 XsSJqncx7XlGw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6D89180AFB;
	Thu, 20 Aug 2026 18:55:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists1.osuosl.org (Postfix) with ESMTP id 04CC62B2
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 18:55:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 029998098A
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 18:55:47 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id EYgfsNntxl1s for <u-boot@lists.u-boot-project.org>;
 Thu, 20 Aug 2026 18:55:46 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::c33; helo=mail-oo1-xc33.google.com;
 envelope-from=trini@konsulko.com; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=konsulko.com
Authentication-Results: smtp1.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=konsulko.com header.i=@konsulko.com header.a=rsa-sha256
 header.s=google header.b=kVAFUwyJ
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com
 [IPv6:2607:f8b0:4864:20::c33])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2CEC580986
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 18:55:45 +0000 (UTC)
Received: by mail-oo1-xc33.google.com with SMTP id
 006d021491bc7-6b12d146e6fso131829eaf.0
 for <u-boot@lists.u-boot-project.org>; Thu, 20 Aug 2026 11:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=konsulko.com; s=google; t=1787252145; x=1787856945;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BKAmxBcUWmXXHnDn/5AhTaRfYWaR2FujYK0OBgwxcJ0=;
 b=kVAFUwyJ/S/pViC2glK/YaMZGK7WnnO+U9sOt4apf0xwMaHyu6ZqwHmB0I/JNVaCc2
 MY0i1D8JPLD/kk8nu1ZTcUECHz7DY1ANACyKuYZs5bT6UhC1pqGEsAI41v6Xm+MnuzpT
 8FKhH8uLUqOqVvvOe2evhC92Q2syypGhZ3os4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787252145; x=1787856945;
 h=content-transfer-encoding:content-type:mime-version:date:message-id
 :subject:references:in-reply-to:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=BKAmxBcUWmXXHnDn/5AhTaRfYWaR2FujYK0OBgwxcJ0=;
 b=gLEoCLdEZxpWoEYT6E2TucHIrCdp8/n2fSHIflm+TMX1mwKJu7+TJLeUKnPsK0SqHg
 dUlUzowb3HoZInwtRODTTj6VVS8tUhS7DmjM3as1lXK0AxLsbz7s98kiZWyPJp5MdoiZ
 KWIvuTFnxWVuMt08SHkKjUdyOwuyMVEdM56AC1sUZxqM/v7EGxz10J1GclPKdUVW0QYk
 CAyFWehI38lejZmW7BQi7uacihjve0dp130X8Mnh4/6QDkOrwuxMeLLCTP5+jImQlmM2
 fsZePh4ogM8t9pMTPJS2iOP6Av24PMyRVWHDzwlW5bKOH5ms8HzXDGMCQG3/3Y0NjZUY
 IAOw==
X-Gm-Message-State: AOJu0YwHMp1zDIfCeqLy+UPcHqmk6kxcmOE0J45ODOe1Xj8iZGOCh1xw
 eu8V3/2a2SDsiM0oNQa9bzYSueytVA3xSPru5AUMvMpPQaliQDSNoJof4okbeNTnK7Y=
X-Gm-Gg: AR+sD122kPKEYvV5fpspUZ/WHzzoG2LLFNNQuevcBJV072lZnbID+vpTgcmPt7nEfv2
 hUvi5yiqJ1HHBGIfLzo6lpvRmWZIpl0DdC9doU3g6y4GAcGIKZVDID1R9kCPJy9iLG1sL4Vp7iW
 Db18T5NJ9wjRQlcJvo1hsYiqTWwWZOePeO8kkEQnE8R7P7fCOkW+yWr+PgoqYBb9JBmLMeFKbhX
 hozFjcXTekRmGHsTm3QIIMKozB4x/vPU3yIBaQgKgxw62kLFqPKJVGUYhq2cvYbr0dLzOUylVxb
 YBVfPZvmKf4hX66s42/J3OD4CHQsj0bb2m1KQHdINcR4k+X83Gl2YK4N49cAdzPOihvB3IVl1XG
 jdohMQBRCV4nJheh0IcT9T7npw3uhbQl7i7QZRZrpK0EaZQBXPzc6XIPnlFyBDPOkMSLhxQHN9d
 eR8NcxlAZLBXnw505Oxuv4NBptnPmTLFgvjVGUMqN2hwgAy/UsnWVF7L+E8LbuZII7RjbzG24OY
 o8Ej3fgVFLcjz0ZAI1cY/VjUZHQSNItxXGpWOJI6m7SXpalCcjJZRRjROJZB30LyFcuoiB/99xW
 2GWHrKrq
X-Received: by 2002:a05:6820:220a:b0:6b1:3f1e:64a6 with SMTP id
 006d021491bc7-6b1593e6f2bmr836752eaf.23.1787252144912; 
 Thu, 20 Aug 2026 11:55:44 -0700 (PDT)
Received: from [127.0.1.1] (fixed-189-203-100-56.totalplay.net.
 [189.203.100.56]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-6b13cb55782sm5729175eaf.1.2026.08.20.11.55.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 11:55:44 -0700 (PDT)
From: Tom Rini <trini@konsulko.com>
To: Aristo Chen via U-Boot <u-boot@lists.u-boot-project.org>
Cc: Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Simon Glass <sjg@chromium.org>, Aristo Chen <aristo.chen@canonical.com>
In-Reply-To: <20260808004437.4367-1-aristo.chen@canonical.com>
References: <20260808004437.4367-1-aristo.chen@canonical.com>
Subject: Re: [PATCH v2 0/2] gunzip: Fix spurious Z_BUF_ERROR in chunked
 gzwrite decompression
Message-Id: <178725214419.2214048.1042490044525402953.b4-ty@konsulko.com>
Date: Thu, 20 Aug 2026 12:55:44 -0600
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

On Sat, 08 Aug 2026 00:44:32 +0000, Aristo Chen via U-Boot wrote:

> The dm_test_cmd_zip_gzwrite sandbox test occasionally fails in CI
> with:
> 
>   12582912/16777216
>   Error: inflate() returned -5
> 
> The chunked decompression loop added in commit 58e523fedf48 ("gunzip:
> Implement chunked decompression") treats Z_BUF_ERROR from inflate()
> as fatal. When an input chunk is exhausted at exactly the same time
> as the write buffer fills up, the next inflate() call is made with
> avail_in == 0, cannot make progress, and returns Z_BUF_ERROR. Per the
> zlib documentation this only means "no progress was possible" and the
> call should be repeated with more input, which is what the reference
> implementation in zlib examples/zpipe.c does.
> 
> [...]

Applied to u-boot/main, thanks!

[1/2] gunzip: Fix spurious Z_BUF_ERROR in chunked gzwrite decompression
      commit: 58b49a7b54bae6cf524d1c0f17a9285287b91947
[2/2] test: cmd: Add gzwrite chunk boundary regression test
      commit: bf219c69ec5bc5ed7838a5452cff2a690a10f9f3
-- 
Tom


