Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78EE5D68BE8
	for <u-boot@archiver.kernel.org>; Thu, 18 Dec 2025 08:28:49 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id F23EC83CF3;
	Thu, 18 Dec 2025 09:28:47 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=pass (2048-bit key; secure) header.d=mailbox.org header.i=@mailbox.org header.b="pblZ8uoZ";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="wt4bVCLv";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id 5E23A83D00; Thu, 18 Dec 2025 09:28:46 +0100 (CET)
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 9BBB883C2B
 for <u-boot@lists.denx.de>; Thu, 18 Dec 2025 09:28:43 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: phobos.denx.de;
 spf=pass smtp.mailfrom=marek.vasut@mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4dX3j72ZRkz9scX;
 Thu, 18 Dec 2025 09:28:43 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766046523;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nuXj33jhO/w+zPKwistqs9ftp4c55xE4gdvsZz5FAY4=;
 b=pblZ8uoZSaVOMGY9IEWLEIqy4YGbZMQQJSrQy7tIupotf3OXsRdjSrNifvxMJp2bPGZQgW
 D6kjiBxw+0Q3ZpeqZFoH9A1Ay5m2qzRgsfkElwFd2hj5Gm5WPFWYbmCHPHRs7lzjXe1Kzn
 e3oegESc4LZ7GMAujQ9QlT+fL9E8+cHjEbNe/aJbOok+TL315R7TDE/5aaVErtHaAIOhkW
 pOvJNXziDhXCm2QikHrwAku3+xpFy8xm7i7wjrwJBIn5Jmv1r5+9a+nVwT/RW0IExz8DOK
 6AAVm/RQMQvZHX5w/Y4ZJqgo2RYJY5Jv5tSwOdVId6/UMAdBqLOwjjCqTlM65g==
Message-ID: <1f4f17f4-27ba-4c24-96ae-fafda9caf3ce@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1766046521;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nuXj33jhO/w+zPKwistqs9ftp4c55xE4gdvsZz5FAY4=;
 b=wt4bVCLv5rMPQ3/tGc19Zq9Wj+6EP8yIroIRhAgEwRAhghlFi6s/QsM9xJEIEcya+r3VKm
 W99lh4upr2hM/SZul1ZYw449M4BTVtJoi2twQyiIv2XNPJGnsUJO1cSbSvKh2+engikQbx
 L8iIKdIhLTXdEjuu6SjAUMPKkZ0diwO/91H28Zf8apvdshHjK7CQJ8RXj/lxam/Zl1zzni
 PVieySADTXbiQBpEKfxu6LTfQ0au8GaZR7dMkSz5MrDZUZ9rJqEa9ZhmQHu0fESbGFY62J
 bU2/PJyZ8CKm/saWK06I/ZJD+aQWl2ZJEqpQ6z8EA90lC6fxHDA+DUuTyBlrbQ==
Date: Thu, 18 Dec 2025 09:28:35 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v4 1/3] clk: scmi: Fix typo scmi_clk_get_attibute
To: Patrice Chotard <patrice.chotard@foss.st.com>,
 Vinh Nguyen <vinh.nguyen.xz@renesas.com>, u-boot@lists.denx.de
Cc: Lukasz Majewski <lukma@denx.de>, Sean Anderson <seanga2@gmail.com>,
 Peng Fan <peng.fan@nxp.com>, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>, Alice Guo
 <alice.guo@nxp.com>, Patrick Delaunay <patrick.delaunay@foss.st.com>,
 Valentin Caron <valentin.caron@foss.st.com>,
 Kamlesh Gurudasani <kamlesh@ti.com>
References: <20251218-sqqs-v4-0-ff95bf2062ab@foss.st.com>
 <20251218-sqqs-v4-1-ff95bf2062ab@foss.st.com>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <20251218-sqqs-v4-1-ff95bf2062ab@foss.st.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: 895a7d465023dd995e8
X-MBO-RS-META: gc78hr1ahhfopwfusz47oqsibx5uaopt
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

On 12/18/25 9:25 AM, Patrice Chotard wrote:
> Fix typo attibute, rename scmi_clk_get_attibute() to
> scmi_clk_get_attribute().
Reviewed-by: Marek Vasut <marek.vasut+renesas@mailbox.org>
