Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2A70E748E6
	for <u-boot@archiver.kernel.org>; Sat, 30 Sep 2023 21:52:36 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 78FA287083;
	Sat, 30 Sep 2023 23:52:34 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1696110754;
	bh=CeyuBykVpPlE2DGzvoKuWNsn5SPe/PLD2jCTNNaRy5c=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=aSqiU0z8BOKk9HzNKGUCKfacGnNATlV4I/AiB2vvKZUgAqS50xfcQHf9pF5W9Xpq8
	 KsI5FJMRd0J/e3dnsgc9guz3ZWRl1JLHYg2bQjcMXU8fMFEs51AQ4KQlOJ4zkpimzP
	 FZQW5+y4LdL7/30MJEYQBqW1JJ3haddaTl5G2qDjoHBiiLQKTGa3CAqT0/9d8VW1go
	 k/8PZLomIeCu+raNeD8YaUkVinPDVXAzacolWJsmowRPZdH9GbyORLyjFY7f+kKCIE
	 pKTBm7wDPcgzjJ4SVcdHMjeLra0hBMQvZgPqfsVNxQ4/UZEBiVgnDqGx8v3/fRhxWe
	 XP9bnEsgMbjAg==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 327A687079;
 Sat, 30 Sep 2023 23:52:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1696110753;
 bh=CeyuBykVpPlE2DGzvoKuWNsn5SPe/PLD2jCTNNaRy5c=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=medq66POngseMDDI6JGdXL0en7OHTHoNI0A30rN2atnxyZ93EhnlYYGxdX6J+44mx
 1ncUN1gqtyNeZ7TulzjMUdXGLMfcSMFZ8pdF02CGEcnpXRBviDoVM/qIRWKRtpldDI
 SPdPVF6uCWrc3mANwS9aOQeX67XLlvvEjjVaQn9CJmX/ELJNItm1L2w11Ge5pDLdEo
 +QSEwb/tIGnAKlazhUBRc5qJWbgjRYgO0A71KmtTqItv+OYDs8B1kAMRwbE/1X0Lt9
 i/jXK2VnzpBcVBhGBFWvC3zCHTzCSJq2CpqJPTKrYd4MbdgHEsrf2vJZkjn9PqW/hF
 oTbcpr3oFbL3Q==
Message-ID: <7943bfcb-204d-526d-9208-fd38fbc567b4@denx.de>
Date: Sat, 30 Sep 2023 23:02:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/2] board: dh_stm32mp1: Only print board code with
 CONFIG_SPL_DISPLAY_PRINT
Content-Language: en-US
To: Harald Seiler <hws@denx.de>, u-boot@lists.denx.de
Cc: uboot-stm32@st-md-mailman.stormreply.com, u-boot@dh-electronics.com,
 Patrice Chotard <patrice.chotard@foss.st.com>,
 Patrick Delaunay <patrick.delaunay@foss.st.com>
References: <20230927124625.247858-1-hws@denx.de>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20230927124625.247858-1-hws@denx.de>
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

On 9/27/23 14:46, Harald Seiler wrote:
> Ensure that the SoM and board code information is only printed when
> CONFIG_SPL_DISPLAY_PRINT is set.
> 
> Signed-off-by: Harald Seiler <hws@denx.de>

Reviewed-by: Marek Vasut <marex@denx.de>
