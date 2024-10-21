Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A066D15D82
	for <u-boot@archiver.kernel.org>; Mon, 21 Oct 2024 12:19:45 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 45C3C88DC8;
	Mon, 21 Oct 2024 14:19:44 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1729513184;
	bh=TIxLwO0Kt/QjyhKnsy0FFZ7ihiDhbltI2WzmUbSSajY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=hB8ePEWyBxMlRi5OjwN9Y7NCdxNLgIRBXUIZo4boKiX2mgdzAyAkT/7IxCFP/nsAK
	 sAYEhM2qW+NPPHH8ZHP489tQXIVzK62scJ08tT4hXdLA4RRqkqtRmoYc4jgisp4flC
	 cyUiDwZHHQArhvgST+ZO4Gqog7rh+BxIMN88m05y96sOnTRlPKQEtogXA9Hjs5IMCP
	 By+AgQxmMnbQTJGkPAHQRQXXLDscBwVufhLqbyv3XjYl9YC8ERpBCqN5ZfHW+dVS1r
	 hZeNvxmL7tgLNEzZMNaLK2jVD6P973VmFv4JlT2j40jT1W/biiT0QcrqC/W2i9HjQQ
	 eu9Nq/qq+FrWg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 9AAF1883D4;
 Mon, 21 Oct 2024 14:19:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1729513182;
 bh=TIxLwO0Kt/QjyhKnsy0FFZ7ihiDhbltI2WzmUbSSajY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=N2zMFjo0mXnvB6xbUz9D+bKVF5gKiOqvZ2pEIf0fh8SpckJFS//xBgwmCkv47NgwB
 fzGMAD0v/UZZSRWLqT2ZTOkpSfh6pZlpTK08tToDbbRnMqddtansVicon/A/0zfOrq
 VIRSRDr2I90mFALa6bbs7wQ8qGlggqEcInpVSdnvOM7MJ3RRDzg7FDXWqliM3ui3ea
 8sSZ3YsrbCuifL9H0QURDtJsQcxg+p4i0poGr43ufcxjQZJ53CQ2N4QSqvM0UiDgOv
 BD0+KKVdA+K6zewskIF4PpyYm7UJJHxbUnsYW0nUFaqlVLjdxtuBi85U/LWxCFuV2x
 c3cduV7Rv4SUg==
Message-ID: <7d5feec4-cf09-4f6d-a858-0ae3e7bdff93@denx.de>
Date: Mon, 21 Oct 2024 13:55:54 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/25] mx23_olinuxino: Drop status-LED code
To: Simon Glass <sjg@chromium.org>, U-Boot Mailing List <u-boot@lists.denx.de>
Cc: Tom Rini <trini@konsulko.com>
References: <20241021113839.318572-1-sjg@chromium.org>
 <20241021113839.318572-4-sjg@chromium.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241021113839.318572-4-sjg@chromium.org>
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 10/21/24 1:38 PM, Simon Glass wrote:
> This is not used anymore, so drop it.
> 
> Signed-off-by: Simon Glass <sjg@chromium.org>
Why not enable the new DM LED here to avoid breakage ?

DTTO for the other boards ?
