Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DB60C5478C
	for <u-boot@archiver.kernel.org>; Mon, 26 Feb 2024 08:54:58 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id E1ACB87EA8;
	Mon, 26 Feb 2024 09:54:39 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1708937679;
	bh=iqMJHKudHU4qk7hik+a4kfC69GeMlg76Ca98q3ceqkM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=lqpqTFwW1rtJJqMDWxZ2dbcv7uZp2g66BSxS8yPsgDmOzpP4naWipTZyYqMC1kCay
	 DLYaMAY7Ufrg7rPBhJK+ZNM2t10GikvmPrpTYE7EtUe3wbpqhgWrhBjGr2u3WxMgw/
	 pQeWXpzxotqzpsBxMJIH8xq1PlAC0ubx3euoUF5QKZfs812hy5zIsakqzPAV9gQF8m
	 MyEYbcliMfs7q5a/Orx+pyDzOo1cyrrA7ZEBrWdxYoSr9E4FXwrghB+BnNjjlNubE/
	 UrK3LTLaHCzSA2bOrPcGWGBxiqr7haI6YxtLVisDBAxwk378lbB3fAILXGzrRMyqgX
	 gnPYYWKCrHnKw==
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
 (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
 (No client certificate requested)
 (Authenticated sender: marex@denx.de)
 by phobos.denx.de (Postfix) with ESMTPSA id 7FAA687E98;
 Mon, 26 Feb 2024 09:54:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
 s=phobos-20191101; t=1708937678;
 bh=iqMJHKudHU4qk7hik+a4kfC69GeMlg76Ca98q3ceqkM=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=pf82FS0R780VcgN4VC2CwqdysjNX2JvEVkmjdeetq8yLZdpnmLoLkB6BGcsaH1x1u
 ZTTpW9NFy4vUeyfHoyCpDCfSoSY/mQVe6IU2qdonebyU/6q2kfubVK7eDQ9LZW0YUf
 qjWfYHpmf3Y/HZUJz2+4KY9LcLKsDdsKAVO30URn5BKRxGpjtilABQh1u1y8FZFizh
 crhBDhGycfXv0cfwX3/mMgUT3dLTroWC3ZET+gFt1sxiV2xeDcUTulo/TwUIW6649s
 NjUhguqirBMk7liO+PW0Ci3+Z1QwX7pqZMesm6EYojLO6Rcqh5PJ9OA8L9APn+wGGO
 dne0fHOYKd9ZA==
Message-ID: <c8f5815a-bbec-4efe-95d0-77dec441a183@denx.de>
Date: Mon, 26 Feb 2024 09:31:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/8] reset: imx: Add support for i.MX8MP reset
 controller
Content-Language: en-US
To: Sumit Garg <sumit.garg@linaro.org>, u-boot@lists.denx.de
Cc: marcel.ziswiler@toradex.com, francesco@dolcini.it, trini@konsulko.com,
 lukma@denx.de, seanga2@gmail.com, jh80.chung@samsung.com, festevam@denx.de,
 andrejs.cainikovs@toradex.com, sjg@chromium.org, peng.fan@nxp.com,
 aford173@gmail.com, ilias.apalodimas@linaro.org, sahaj.sarup@linaro.org,
 fathi.boudra@linaro.org, remi.duraffort@linaro.org,
 daniel.thompson@linaro.org
References: <20240226080433.3307154-1-sumit.garg@linaro.org>
 <20240226080433.3307154-3-sumit.garg@linaro.org>
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20240226080433.3307154-3-sumit.garg@linaro.org>
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

On 2/26/24 9:04 AM, Sumit Garg wrote:

[...]

> +static int imx7_reset_assert_imx8mp(struct reset_ctl *rst)

Linux calls those imx8mp_reset_set() can co. which is less confusing 
than imx7...imx8mp() , use it.

In fact, why not copy the code from Linux outright ?
