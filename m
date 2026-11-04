Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14313606A68D
	for <u-boot@archiver.kernel.org>; Wed,  4 Nov 2026 17:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=W6eczc3V;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=U5bu9ljj
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DBC8980C4E;
	Wed,  4 Nov 2026 17:52:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id SZ3k8kVWOKiG; Wed,  4 Nov 2026 17:52:02 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org F3ED780C6C
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793814722;
	b=Qzpz1WnkwqKC9qii1+Sab0MOA2Vv4cGV9Zau/XzwY53xN5UVCkd5zs1IgySp570kF9i2
	 xhWPWeelFmH5l5R5t55YCfWBe/B134Nfp+xYdfMjd0gFRR2xHCK9FwLuSZ8R0vcUz0rDq
	 6pncblFSsVMoyvBtz6/Huvl3kkRJJv2uf2Q8BDnOUzkT94c9/qyjZw2dekph5EcGSg312
	 BYmQpRf58P0YZDEQxyGqoPiA02YlBsD0megGh/W2In0UkL87GwdG5+pHZ3gD7b5PvRnKB
	 DVh284A3Bf0k/Br8Uca3pJn17tZ79Ct8VdQGS/s6YD5y3TWJNvR4gn+z43htf9PIzFQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793814722;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 Received:DKIM-Signature:Message-ID:Date:MIME-Version:User-Agent:
	 Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=2GvRkgrMxUPOPjwMgjmd4c9BMFt3nERgwe4NjCfjlTk=;
	b=OFDJoJZ8/3jyDupOT4z5BtRfgIDC121Lefmc/g4ZGxyBtG+bY99Sf4goA7qWrVS0SnON
	 x/7HDv4VccaSC6DjNaiTjAB06yI9I/VA2UIBBK708fEnprycU7MQLlUlBL/vMxwbJR+8W
	 qFd+roPbg+i1h8XxPrIOzDm/4pCiQ5edhovzSDc97Hq8IajgPS6nD+RfsmKKhdEki81tm
	 3CV2d2DP5ssY8J30o/HLs1yqgKsDClUpselEIs8j5Eb3o5p+Rp8R5ezsYE40K+bL9e8uJ
	 tELdpAJBUBjw37U4S8kICo3gIt0ZvSVBuChG3OvXkr3Ub+jaMl/IZE45fBz3sWiIAqw==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793814722;
	bh=2GvRkgrMxUPOPjwMgjmd4c9BMFt3nERgwe4NjCfjlTk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=W6eczc3VZwDX7oOTDMavDCZIsO3CWZhcrs7EV2lowkq3SsoHqU9efbV2d9EF/9y3Q
	 t9WrbWa3BjtM5rMj7viSiNeby0J+jO3Njm85CJY+ndIdE2CsNicjL0pcCNPRDnKLvK
	 eliSQN5h+YwvGJLpTcW4244l1CahX1Ez9gODCwyvFAH3oyVJnJ6hZjwL2PSip6s4Yw
	 rBO5Oru7RjiEp+wiTgPzWkS2bBL5XUkCoXVs2ep07x3cLf+0Ys4BIGFNxr2ascFpiu
	 rZjZ38q9KNp7pbzjzWP8HHtK5JVXmKYhagExZa31HmkCGLQjzFHuxJttUO0hj6/ilS
	 WV9xNMo1RRA8A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id F3ED780C6C;
	Wed,  4 Nov 2026 17:52:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id C3AA7280
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 17:52:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B581C606A7
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 17:52:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 4w1W3BHBtQLj for <u-boot@lists.u-boot-project.org>;
 Wed,  4 Nov 2026 17:52:00 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org C9922605F7
Authentication-Results: smtp3.osuosl.org; arc=none
 smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org;
 envelope-from=chleroy@kernel.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=kernel.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256
 header.s=k20260515 header.b=U5bu9ljj
Received: from sea.source.kernel.org (sea.source.kernel.org
 [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C9922605F7
 for <u-boot@lists.u-boot-project.org>; Wed,  4 Nov 2026 17:51:58 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2DEB441F9C;
 Wed,  4 Nov 2026 17:51:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 112041F00A18;
 Wed,  4 Nov 2026 17:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793814717;
 bh=2GvRkgrMxUPOPjwMgjmd4c9BMFt3nERgwe4NjCfjlTk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=U5bu9ljjrxPWj+5t7WpqhrUALBQKGJDm35AeFF5RvQs2ibKtl0jCgaHoKXdDvmIk+
 hQgHUbpN+iwM1BnlqaC/JkxiOqGxvNlH8zl0JdVc6baCOZNdWsS8btnbCFFW7sj8Wv
 8xlmfhCE/g6/WGuyO95oNM/x/swnOsGf7YhQco+Wi0HU38XvY0Xd6k66gXbrtUUJjd
 tyWvkhfCCFbUj23p2XHkOqxk/+5Aqp1r4fbDSyCtzgHTYC1PTyoeIJl8KpF4ZZbVRl
 A4kowLWl+63evrGnp2YU3Oyz7TnRzWk3tnET9RdAtPecU2M7MAiyH3CFoxo0knEFQZ
 2NVCxm6mzx0Og==
Message-ID: <3959b688-e0a0-41fc-9cc1-72806d71d30d@kernel.org>
Date: Wed, 4 Nov 2026 18:51:53 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update my email address
To: Bradley Morgan <brads@mainlining.org>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.u-boot-project.org
References: <bd82ee029f9df32b85f4a1c90016fe98852ba92b.1793711640.git.chleroy@kernel.org>
 <179380922199.29991.11743513763065873100.b4-ty@mainlining.org>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <179380922199.29991.11743513763065873100.b4-ty@mainlining.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



Le 04/11/2026 à 17:23, Bradley Morgan a écrit :
> On Tue, 03 Nov 2026 15:03:07 +0100, Christophe Leroy (CS GROUP) wrote:
>> Some people have reported christophe.leroy@csgroup.eu being stale
>> from time to time.
>>
>> Change to use my Linux Kernel address chleroy@kernel.org
>>
>>
> 
> Applied to main at u-boot-ppc, Thanks!
> 
> [1/1] MAINTAINERS: Update my email address
>        https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Fgit.u-boot-project.org%2Fu-boot%2Fcustodians%2Fu-boot-ppc%2F-%2Fcommit%2Fbe7b24b50d13&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C1314009a4c2545fde06d08df3a90031e%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639294062364712352%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=DIN1SgCk%2FSUJjnB9hxQoWG6T9gH4lhApnwWyk1KzJTA%3D&reserved=0
> 
> NOTE: This patch did not apply directly, I fixed the conflict:
> 
> --- a/.mailmap
> +++ b/.mailmap
> @@ -41,6 +41,8 @@ Boris Brezillon <bbrezillon@kernel.org> <boris.brezillon@bootlin.com>
>   Boris Brezillon <bbrezillon@kernel.org> <boris.brezillon@free-electrons.com>
>   Casey Connolly <casey.connolly@linaro.org> <caleb.connolly@linaro.org>
>   Chen-Yu Tsai <wens@kernel.org> <wens@csie.org>
> +Christophe Leroy (CS GROUP) <chleroy@kernel.org> <christophe.leroy@csgroup.eu>
> +Christophe Leroy (CS GROUP) <chleroy@kernel.org> <christophe.leroy@c-s.fr>
>   Christian Kohn <chris.kohn@amd.com> <christian.kohn@xilinx.com>
>   Christopher Obbard <chris.obbard@oss.qualcomm.com> <chris.obbard@collabora.com>
>   Christopher Obbard <chris.obbard@oss.qualcomm.com> <christopher.obbard@linaro.org>

Ah ... One more Christopher Obbard compared to main is the conflict ?

By the way, isn't Christophe after Christian and before Christopher ?

Christophe

