Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0071F606A31C
	for <u-boot@archiver.kernel.org>; Wed, 18 Nov 2026 13:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=vOAAbtaW;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ZqTh8pfk
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CF5C881208;
	Wed, 18 Nov 2026 13:21:37 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id WH1Wx6xxPXHe; Wed, 18 Nov 2026 13:21:37 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 0CE9281286
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1795008097;
	b=dDRVkhx6E5Osi/wyT9sVel+iTZZsKiaP/lw0qAGs31Vw1wxektTKBICsc01NYVJovO72
	 xw43J3dQ5g3P+c051+MP5T6vtLdE9Wg1XDdKJbeRaNOW6Y7gsVCeFDr1sPbX65l5aF3sj
	 h1ui6opkxEqvd1LBk0WK/uNXz7lfooeNwrHy4t5vKzPtfvZZbjQ0LuTcBj+oMtE63DRLB
	 rC6+q6VXgYGGUZ2uOJtv08RpU3mU1dUU7CPOC0sWwclOZvNYmv8lxkVsxuzXyLV1NMpEF
	 c8ytO8GIZnv/kRRfuSAh861FdhYirIN7hSMoHyj61o5x2f+ALQDRIfw3vTrgDjQOKYw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1795008097;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Message-ID:Date:MIME-Version:User-Agent:Subject:
	 To:Cc:References:From:Content-Language:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=ElRVKxb8oPDfiAdVQaXc8Wi6Yc+3yHAxEQNLr8pEKPs=;
	b=IRKThFw7zUnWsLOX2VHM2mBNyIwhHbkJ79OUiIGmL7CqGGyvA7mcpKOUAomCWKsgDu4f
	 NFfriZKnkJVB+x44KtV5/nZfljToAOV1fREXI/GCyJVjHSKE1DmpQ8SCrfclfQk2MkOYa
	 NAxlmPSb9JWCrzYOCDNrt3ktdVbbPjZ0/c9vNKhZr7K+ZKNOcMsJFQGdIMHMah4A8JolS
	 ZM56LQwL5UxE4OSKRYlR1ZcbZkOTLAXGkhkmS0sFYr//GptJmyXmvkaLfze30yV0ZcmO8
	 HjwUJJw32Df/SfoKa58GVvi/9fh+fm7ebrMKPIy0BS64YJRLpk7ldnBll+PoOWLdSyg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1795008097;
	bh=ElRVKxb8oPDfiAdVQaXc8Wi6Yc+3yHAxEQNLr8pEKPs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=vOAAbtaWY2zJ4xC3CUWnFC+OwVxNY+Huau8FGfejPN7Nx0xPjcX/O9F724d+DZP75
	 NCURN933Mnb4HztoHy1hjxLI/0uJnSdG73x5XXUhVQn44L4d2qN6hJtznn5clee4Ic
	 hs39RC2v3oUv4v3/AkTvi+M9Au/+IG8rwuEEc50OyPlYYt2ufIJhyj4OQ6H/5TnF2v
	 iA/Tm8o7OGhl/l6sOkfKrDM+pr2WaPh+YkGbm7WDAZaAK6Bcg0UYrX3PnnkE6GHhsN
	 qDjQN8awXyJBg9vRNQby24y1sbXxRzqsXB6L1vAF9Fdeq3cRTTZ4IllJoj4FlDbRPh
	 kjY+VVFNdV45w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0CE9281286;
	Wed, 18 Nov 2026 13:21:37 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 8871870B
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:21:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6E72840A09
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:21:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id QJKRaOvQmttl for <u-boot@lists.u-boot-project.org>;
 Wed, 18 Nov 2026 13:21:32 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 724F040A02
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2a00:1450:4864:20::329"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2a00:1450:4864:20::329; helo=mail-wm1-x329.google.com;
 envelope-from=alpernebiyasak@gmail.com; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20260707 header.b=ZqTh8pfk
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com
 [IPv6:2a00:1450:4864:20::329])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 724F040A02
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 13:21:31 +0000 (UTC)
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4bb77a462c6so14082765e9.1
 for <u-boot@lists.u-boot-project.org>; Wed, 18 Nov 2026 05:21:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1795008090; x=1795612890;
 darn=lists.u-boot-project.org; 
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ElRVKxb8oPDfiAdVQaXc8Wi6Yc+3yHAxEQNLr8pEKPs=;
 b=ZqTh8pfknbsn3B+wjIfv2eGpWM3MtTWDH6Nt8Z1aOeeLmqICieb5UjxO//AxIBSsjU
 QGvFzlRmSHG0N4PLYeyl1e0WYvbGXJbqKbgUzhlS9V/AUEk8fJAl8o4Z7iltvz4GYS5y
 eJMT3irklpCizsHhSHJhEjm03lTKzW9dcSYM/4lPpZyA2D6ps717sK1EGbgrvej2YTfy
 49GybpyI02rP6F/g/E+nGqw5bD93UKVg+eO581kQvICjB6lBhK1V+7ZRWoUHJ9sRwpky
 1X7+G7NE3sFP8Qfj73M51xijl4lvm0oO/M0ckrK5eakK64Bb+14s7X557FHMWV67/BfT
 F2WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795008090; x=1795612890;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ElRVKxb8oPDfiAdVQaXc8Wi6Yc+3yHAxEQNLr8pEKPs=;
 b=i5Yyw8Uo++H1XqyTdT21Wd3/n1wLD+HMGhJk2aZlpNhVgo3TOu7drQNEwpqJp+oS6F
 PxfkPam0rh8kaz1nC0iJ/QJol4sx+BM6yeDjOR6rGLRb8TFiw1hzMl0sWkfcYDQNYc4I
 yTy0hvi+/3x/yklQDc4XpK3HOtcWXt1KKzfehgCMtZN7rrE2UxWwUN08D8urDnfU3g+Z
 nzqZqIc5SOkVzpIhcuVOanHkKJoH4ZpH5FpPTf2IUdF3dHT5TzT1QRgz1toIaTE13/D0
 sFGnJTHupD86by8L/ltq8txPylOvAvLGEUTFLPxlF39jgJ5w+DZ4c2J49sS3aZtaAUCx
 lPNw==
X-Gm-Message-State: APuU4Z+RNrTnUpVzy6H1olz7E3GpHMvaFKAbyqV2PV2eSXP52bA9N8Pk
 8KhRm4qHzClhqo9f2U6UfzZptTWrHtflmHWA4uaOUQ8C8iepf+EWRqc9J2oOP3K9
X-Gm-Gg: AYBFou0ArG1B7ou4q9kNeRwTaunrSQniYs0zQ5MM7XWF/cb+0tH3b4cHo8IfsBuShc+
 6DAb7p32FCsZmrgX0g8bRy3WpnVfuTJd7UPwbXoZpuCrqX5IZnAewwCuJDGVlSyHNcu2ytmf6HW
 I7jlfaYxJHL7Wa6ERmnm4FduWRikrFeUtCygnDRcZXyq7vTKHFvoGcqJQS7Mt2r2iRdXlJHVO+T
 oc2/sb2we+pYF7ot62wGoBunS/NhS9zTrCNn9iEPdqepe36iZWtTjMwJAZktZIP7fO+ohMbHX9L
 3piM7yd60FirFA2sltPwra21cCIWTLAtQ4oIZkav+o34XG+2MxIqLkNMUgBSxpIrLxssg4gfjGP
 75dzzIv57iiDBW61YNdEkg+l+5bkop0gmJU01tpcmGVYtpqovDU59Do3+l5nHshMHtIgOmVgu8K
 KqbwR8+uZSgs6qNKgvHlzorhuWrsv2kJuKKBulTjnCUHKNIvxoc1wMFgzbHKUXq1ZwoHAlD2n9J
 7lTBZu+Cw8si2vZSuPY/xI+BdciaiH1+tbpZ7s36OKClnwlb85mm19t8fGv5D8xE9uHgOIcr1us
 ulZpAEfz4RoX1nl087pkMTW+7TFpu4+VrtaTZoxU0SYIFOAc4+wtTlcrxLbu
X-Received: by 2002:a05:600c:37c3:b0:49e:6581:7baf with SMTP id
 5b1f17b1804b1-4bb7d6cd4ffmr45856575e9.2.1795008089669; 
 Wed, 18 Nov 2026 05:21:29 -0800 (PST)
Received: from [192.168.0.13] ([178.233.26.179])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4bb7d29c614sm66972195e9.4.2026.11.18.05.21.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 05:21:28 -0800 (PST)
Message-ID: <d9ca273d-7e2c-4c77-9b98-1e877ad5e147@gmail.com>
Date: Wed, 18 Nov 2026 16:21:25 +0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] binman: support separate binman devicetree from
 control devicetree
To: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 David Lechner <dlechner@baylibre.com>
Cc: Ryder Lee <ryder.lee@mediatek.com>, Weijie Gao <weijie.gao@mediatek.com>, 
 Chunfeng Yun <chunfeng.yun@mediatek.com>,
 Igor Belwon <igor.belwon@mentallysanemainliners.org>,
 Julien Stephan <jstephan@baylibre.com>,
 GSS_MTK_Uboot_upstream <GSS_MTK_Uboot_upstream@mediatek.com>,
 Macpaul Lin <Macpaul.Lin@mediatek.com>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Michal Simek <michal.simek@amd.com>,
 Casey Connolly <casey.connolly@linaro.org>,
 Carlo Caione <ccaione@baylibre.com>
References: <20261112-mtk-genio-binman-dtb-v1-0-65cfc9329c50@baylibre.com>
 <20261113174852.GN554944@bill-the-cat>
From: Alper Nebi Yasak <alpernebiyasak@gmail.com>
Content-Language: en-US, tr, en-GB
In-Reply-To: <20261113174852.GN554944@bill-the-cat>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On 2026-11-13 20:48 +03:00, Tom Rini wrote:
> On Thu, Nov 12, 2026 at 03:14:55PM -0600, David Lechner wrote:
> 
>> Anyone who has worked on hardware that uses a devicetree for the
>> hardware description should know the mantra "the devicetree describes
>> the hardware, not the configuration".
>>
>> Binman is describing configuration and not the hardware itself,
>> therefore it doesn't belong in the control devicetree that describes
>> the hardware. So we propose encouraging the separation of these two
>> descriptions into separate devicetree files. In most cases, binman
>> info is not needed at runtime anyway, so combining it with the control
>> devicetree is unnecessary, takes up space, and causes DTS validation
>> to fail because binman is not part of any standard devicetree schema.
>>
>> Currently, only Xilinx is doing this kind of separation. This series
>> makes it possible for more platforms to adopt this separation. The first
>> patches fix binman so that the image gets the U-Boot control devicetree
>> rather than the binman one when the two are separate binaries. And they
>> make BINMAN_DTB work with OF_UPSTREAM, and document the recommendation.
>> The remaining patches update the MediaTek Genio targets to make use of
>> all of this.
>>
>> Signed-off-by: David Lechner <dlechner@baylibre.com>
> 
> My more direct concern with this series is, who has some review cycles
> to step up and co-maintain this tool? It's already been privately
> suggested to me that we could drop the lofty "one tool for every project
> to rely on" goal since most projects continued to develop their own tool
> for assembling binaries anyhow. And that in turn reduces the scope. But
> it's still an important part of the project and so needs some people
> looking after it with a more global eye.
Sorry for my absence here. I've been burnt out for a long time, then had
a lot of IRL problems, I am slowly getting productive again. Currently
busy with backlog in another project I have, but after that I want to
continue my firmware work on the many Chromebooks and other boards I
have, including more binman work (assuming it survives a bit more here)
because the general "how to format and parse data in arbitrary shapes"
problem it tries to solve is bugging me in other contexts as well.

OTOH, I don't think I've ever been as productive as an ordinary person,
and the reasons for that are still unresolved, so it's really not right
for me to promise anything.
