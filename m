Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8097BC52D7B
	for <u-boot@archiver.kernel.org>; Tue, 13 Aug 2024 04:11:47 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 1192B87E30;
	Tue, 13 Aug 2024 06:11:46 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1723522306;
	bh=x84TjOo027TnFsIc6nqeyQKtIJ++9mJPQiWZNvhF7i0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=RYnKiRTHj/1DFz66GcyYl/RweiDzu8dWMEo2ta73r4r2HqvqTUdrVqsbhcyqa1SlB
	 Pc16TaomhtY26yadnp9p6TB//cd1fzrjqQPG2GVfxA/xuBzw7z1LLzbd9o+g3xpjk0
	 Js/XZ5r/wiwu7gdxg3yKrLHrN4ucUZ3ux8xNGq67GCw5TnGVPO2Eeub6MX+UTXxE0s
	 BtTMbkzNxQoVVNeS1UwHs5n+Hy1cl3IYWqa1ap4X7uFE2QHpfnvGS6M6XPXcgBxfFe
	 MKyc6yGWkGnwxdwi7Wsa71nM50+GSHxyEMW32694QcshzAJs2jAz8w+MxdM0Ev0e/l
	 Boxc59tHpJPOQ==
Received: from [192.168.1.107] (89-186-114-92.pool.digikabel.hu
 [89.186.114.92])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id D757287E30;
 Tue, 13 Aug 2024 06:11:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1723522305;
 bh=x84TjOo027TnFsIc6nqeyQKtIJ++9mJPQiWZNvhF7i0=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=P8Q6upSZzhL9MrIu+5AFX3Anb2QGBm5TB+h8vWehB9GE+DuaRLx/2OA8KHIf6tYXF
 Rgwpcvc73moPwmGklBUKGHg9x2iEsGlIunoVL9SQybEj5X9MYKLPSx9XTZdWmriUog
 oNtL2KAMnIjK0kcmw623GWRhZ6Hn95n4DT1UumNGkXVYJOK8NRg/OUqw4Wg9sHoE5W
 0nX76uER2SNSEHJfcgOaYcPn5iqhPIHmHmG8CbcfSd7BFXSxTXB20fv662za9La/AB
 6WD8pzs9gm7FzbZ6fts0v0W+inFd6BeJJRpTrYr6U7zxZ9lNJOHC0LC3BkLe0r2fcD
 B1KBARWMARaJg==
Message-ID: <a7afde7f-2039-81cd-4000-02dbef18f169@denx.de>
Date: Tue, 13 Aug 2024 06:10:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH v2 09/18] date: Drop the legacy I2C code
Content-Language: en-US
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
References: <20240811145047.4189460-1-sjg@chromium.org>
 <20240811145047.4189460-10-sjg@chromium.org>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240811145047.4189460-10-sjg@chromium.org>
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
Reply-To: hs@denx.de
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hello Simon,

On 11.08.24 16:50, Simon Glass wrote:
> Drop two generations of old code in this command. All boards should use
> driver model for I2C from 2021.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
> ---
> 
> (no changes since v1)
> 
>   cmd/date.c | 26 --------------------------
>   1 file changed, 26 deletions(-)

Thanks!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko
-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
