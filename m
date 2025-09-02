Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 992A8CA1005
	for <u-boot@archiver.kernel.org>; Tue,  2 Sep 2025 22:10:13 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id DC0BE832AD;
	Wed,  3 Sep 2025 00:10:11 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="aQn6O/QC";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="dSKPmGbs";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id E2C4D832EB; Wed,  3 Sep 2025 00:10:10 +0200 (CEST)
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org
 [IPv6:2001:67c:2050:0:465::101])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id D0D9583252
 for <u-boot@lists.denx.de>; Wed,  3 Sep 2025 00:10:07 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4cGg0H4Wb6z9sqs;
 Wed,  3 Sep 2025 00:10:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1756851007;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xGTya9ESJkp4RSWdP4C82j0KaMR6sZSPLr2IlFRnWg8=;
 b=aQn6O/QCqHte6+NtCicl81CWwHAtiWGKtjgdn5ykBjoguFheHWZEG5ep14Gxfm9OhxznQI
 aGHY7ZuIRO/CZuHb/TY7TtSIXFttzp0gtnEad/cJkUOceozfAecnRvf1QL7fETqeVg41rf
 In649dzPHFFqqB8/20zjSZryuxeasnnocFum/rg93O4TN69MMdg78/LDjnWR6VBQvtqfMU
 6VXkIUTAtl4clYHG3xcPI7guMdMy4EXYuszOcFyYQ+NvLrIVvdFGWNJVAnmFwxZtrObY7a
 24s8ngIZ9qVQnx8gGNUISPxqmWS9iLmh/fgj6dAFLOVQIbk9qR6Rj6fUhF0DzA==
Message-ID: <2e147ca2-2588-41ac-9dcc-c4c7f016f4e4@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1756851005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xGTya9ESJkp4RSWdP4C82j0KaMR6sZSPLr2IlFRnWg8=;
 b=dSKPmGbsyStfjiooe9Ij0BlDieoWNxZNxH5HtghsFftw5aVb/ZvsX/VNOpPFovHVlg3TLm
 ySW8we5Z3Jydyx0zH81yLc1citF99Vihh44eAGI/oX+z/G2Uewa/mxMjjDC5UnsEoMzSZf
 /KoGzrtZXc1TA6pmTV0wbHmlXLYaEsU1H0lMVY9TBhGF2hUzrAFl609SETfdJsIB+TtW2T
 uIDnscuAke6f2KehwkEKgvp75KIYzU0jmkDDvHphYTACsYzTDh4p7vUPzB5GcKQEbfRdsi
 pkaz/bB9rWToHDc+tbeFjUl+U4fIi/hwpAgRe5UEXUvMsdtBJYb5/cMf5N4ygA==
Date: Wed, 3 Sep 2025 00:10:03 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] pinctrl: rzg2l: Variable may not have been assigned to
To: Paul Barker <paul@pbarker.dev>,
 Andrew Goodbody <andrew.goodbody@linaro.org>,
 Nobuhiro Iwamatsu <iwamatsu@nigauri.org>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20250807-pinctrl_renesas-v2-1-5453d989573e@linaro.org>
 <ecde7d398f0ff89cc8fb20a7e3473afe38f215bd.camel@pbarker.dev>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <ecde7d398f0ff89cc8fb20a7e3473afe38f215bd.camel@pbarker.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: uyusj68dtkitzgsnskqbn1f41k9wjch9
X-MBO-RS-ID: ef14b3a0a0212e49214
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

On 9/1/25 9:15 PM, Paul Barker wrote:
> On Thu, 2025-08-07 at 15:41 +0100, Andrew Goodbody wrote:
>> In rzg2l_pinconf_set and rzg2l_get_pin_muxing if the call to
>> rzg2l_selector_decode fails then the variable pin may not have been
>> assigned to. Remove the use of pin from the error message. Also update
>> the error message to show the invalid selector used instead of port
>> which will be the error code returned.
>>
>> This issue was found by Smatch.
>>
>> Signed-off-by: Andrew Goodbody <andrew.goodbody@linaro.org>
> 
> This fell off my radar, sorry!
> 
> Reviewed-by: Paul Barker <paul@pbarker.dev>
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>

Thanks !
