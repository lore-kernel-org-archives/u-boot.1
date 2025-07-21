Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1FE4C83F1A
	for <u-boot@archiver.kernel.org>; Mon, 21 Jul 2025 21:43:34 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id C733D8320C;
	Mon, 21 Jul 2025 23:43:32 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="nE4UDYrj";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="NfTqg8yg";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id B37A3830B5; Mon, 21 Jul 2025 23:43:30 +0200 (CEST)
Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org
 [IPv6:2001:67c:2050:0:465::103])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 419A0830B5
 for <u-boot@lists.denx.de>; Mon, 21 Jul 2025 23:43:28 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4bmDRM6t1zz9sZK;
 Mon, 21 Jul 2025 23:43:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1753134207;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H3pflc7bDO2EcQI9Mnnk0QN1mXC6Zyt71AUqgkRlM38=;
 b=nE4UDYrjcq+Ef1IeJOicz46CsngnmwCHLPkHFDMQ6yIJ1NdsCq0GhxWQka4pz0aLSACOdh
 d5M7jVADq7SSjWTg5tZiextzS2AQPhE9s731R4IJ7FhttL6KDvvZnuMisHcOFXCQXEGcSf
 fPVCsQo/zuEaw1q2oEn89LOoLNNWXH0G0kkJ8lnflvI9YaEbVOIwobP/oJfup7sXzhhrcw
 X1N1VVQkk28y8Z/t3FY1cJA95ATf9pOfTy+gy17i8a9smOk8Idk7wzTDVOpSOw7W2cbse4
 RXz5OztL+THGU0Nu43WafxfsJkN61WIirAl+jALv4Imxi07zxv+xcdzZLtNgLQ==
Message-ID: <a0a07669-2192-487a-b8cf-9d8753a50385@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1753134206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H3pflc7bDO2EcQI9Mnnk0QN1mXC6Zyt71AUqgkRlM38=;
 b=NfTqg8ygt022Wk/pzEDx2PfC2/jdpWpEuEVXYm2xq2C/1oAo4Y346hlDtTqzNNHX4y+Vda
 fw0iNlWvYSct/us5C9yt/PGf1wrpGO9IkjeCXgWNwydauB3nF2C5dGcKTIPzHhD9wa/Vg2
 xHodPMZIsna3I7KOvdLbYyXpCxiQzgoJb0hRM9H6tbartv4kb/PG4bLlo9cKWs6HziYuGv
 0bxoI5Qp5iTqKbJWC8xJTIn5oBxBFq0O6NNXrSgdFM5iz9GQVMjE9UPEDdn/nbQ7VlysNO
 NTpUJA40YTtZT62Exsz7VCjhAEWTnaGMWxJfxhMiQNm8Dvzv+qiPStC0EVtjHw==
Date: Mon, 21 Jul 2025 23:43:20 +0200
MIME-Version: 1.0
Subject: Re: [PATCH 2/3] image: Add support for starting TFA BL31 as fitImage
 loadables
To: Quentin Schulz <quentin.schulz@cherry.de>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, u-boot@lists.denx.de
Cc: Andre Przywara <andre.przywara@arm.com>,
 Caleb Connolly <caleb.connolly@linaro.org>,
 Igor Opaniuk <igor.opaniuk@gmail.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Julien Masson <jmasson@baylibre.com>,
 Mattijs Korpershoek <mkorpershoek@baylibre.com>,
 Maxim Moskalets <maximmosk4@gmail.com>, Michael Walle <mwalle@kernel.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Patrick Rudolph <patrick.rudolph@9elements.com>,
 Paul Barker <paul.barker.ct@bp.renesas.com>,
 Paul-Erwan Rio <paulerwan.rio@gmail.com>, Peter Hoyes <Peter.Hoyes@arm.com>,
 Raymond Mao <raymond.mao@linaro.org>,
 Sam Protsenko <semen.protsenko@linaro.org>, Simon Glass <sjg@chromium.org>,
 Sughosh Ganu <sughosh.ganu@linaro.org>, Tom Rini <trini@konsulko.com>
References: <20250112223755.179959-1-marek.vasut+renesas@mailbox.org>
 <20250112223755.179959-2-marek.vasut+renesas@mailbox.org>
 <4097bdb7-8c8e-42af-8538-41338d49b328@cherry.de>
 <3523e011-b0f1-43bb-bc39-baa8fd2e51d7@mailbox.org>
 <2be1029d-f0b4-4c28-bbf9-3cbb6b1c6156@cherry.de>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <2be1029d-f0b4-4c28-bbf9-3cbb6b1c6156@cherry.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: ca9593a8bb7f958c4e1
X-MBO-RS-META: snrnfwedsaj74ojihmu5u89tyki3cyxa
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

On 1/29/25 6:51 PM, Quentin Schulz wrote:

>>> This would need to be added to the ITS spec, c.f. https:// 
>>> fitspec.osfw.foundation/
>>
>> Where does one do that ?
>>
> 
> https://github.com/open-source-firmware/flat-image-tree I guess?

Thank you for adding the entry.
