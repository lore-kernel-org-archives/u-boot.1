Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB79AC25B74
	for <u-boot@archiver.kernel.org>; Tue,  4 Jun 2024 04:11:25 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 201E588428;
	Tue,  4 Jun 2024 06:11:24 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1717474284;
	bh=rKKSSCpNyiR2mQQsuGpwR37lUgeBVYGUEtWrsyYxazA=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 Reply-To:From;
	b=A0OsUUlWZ5Z7/5ubgZnfFsLyBjxAWo5Fowg8LgaTkU4nefUgNJ6F0ami3iF0W6f1o
	 CLwAWB1sI6aBZl7VN4rwyrQhUqAAxtgeU/A2B5TE5YxwPhy8a9hhEZubzalwgM0dCt
	 fF9PIEgGj4gCpdC1GIYmIP/DL10a6Wu+oGQb4KYmQyUm0EbPajRF2sckCUM1BMzgTd
	 zGroqL2qF0LVr2y27mD11nJaMzyTJnWQ7XLwhklobuUjgbxZBxwM8BZvHhtQdAe1m8
	 IWJEJBaMV7rdd26RG2pncPFXRL8t1tclbLBWgWYnjTk0/+dHLuUPi0AvSzbI8FMSIy
	 KLK4ev7qi8LOQ==
Received: from [192.168.1.107] (91-82-24-13.pool.digikabel.hu [91.82.24.13])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested) (Authenticated sender: hs@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id CBA5588416;
 Tue,  4 Jun 2024 06:11:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1717474282;
 bh=rKKSSCpNyiR2mQQsuGpwR37lUgeBVYGUEtWrsyYxazA=;
 h=Date:Subject:To:Cc:References:Reply-To:From:In-Reply-To:From;
 b=J3eRpqPXsbLwd2sYy71aVCU4WmRcdShiPbQTRLmvbZX0FUfINlL8kdwYq1ieDGl8s
 xIZqo4OCitkXo8raDhlayEp8sjJQCqqazPuLl0hik6w24aireHblXJu+hrsMKrL9Qr
 epuGjuA/csvVpCQmSnXyd9Ny8IyFA7Po4cFxIDk/Gm/YVyJjLzkxonHuU9TWKG+HWl
 gy9yCxdR9W+wvtpWYqL/2SW2OPMkZwrzEbFu/QMgg6W/bE12tLSzxUW+y0rkiyiC4Q
 otBJCtq5TJ/+uebBJPvsb0IOmHN48rZHUio26MSoTjhYqHgcTpaQVHxHJjAlq+TFf3
 Lwtie3Tfl2Y8Q==
Message-ID: <ba79333b-403b-02b5-58c2-23679e59d503@denx.de>
Date: Tue, 4 Jun 2024 06:10:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] fs: ubifs: Add support for ZSTD decompression
Content-Language: en-US
To: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, u-boot@lists.denx.de
Cc: Ben Dooks <ben.dooks@sifive.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>
References: <20240528150528.1982853-1-piotr.wojtaszczyk@timesys.com>
From: Heiko Schocher <hs@denx.de>
In-Reply-To: <20240528150528.1982853-1-piotr.wojtaszczyk@timesys.com>
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

Hello Piotr,

On 28.05.24 17:05, Piotr Wojtaszczyk wrote:
> ZSTD can be a better tradeoff between NAND IO operations and decompression
> speed giving a better boot time.
> 
> Signed-off-by: Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>
> ---
> 
>   fs/ubifs/ubifs-media.h |  2 ++
>   fs/ubifs/ubifs.c       | 53 ++++++++++++++++++++++++++++++++++++++++--
>   2 files changed, 53 insertions(+), 2 deletions(-)

Please add in future a list of changes you have done (You did, or?)
And add me at least to cc (I nearly missed this patch), see:

https://docs.u-boot.org/en/latest/develop/sending_patches.html

thanks!

Reviewed-by: Heiko Schocher <hs@denx.de>

bye,
Heiko

-- 
DENX Software Engineering GmbH,      Managing Director: Erika Unter
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-52   Fax: +49-8142-66989-80   Email: hs@denx.de
