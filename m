Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06CDE606D80B
	for <u-boot@archiver.kernel.org>; Tue,  3 Nov 2026 14:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=r22q3/At;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=UlZulooQ;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=xlGTNOV8
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C284C6080C;
	Tue,  3 Nov 2026 14:51:17 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id tRYUUjw3zBpZ; Tue,  3 Nov 2026 14:51:17 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org E72156070F
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793717477;
	b=seT7+MgZ0dM7k1k30HJUKIPUF4Zep7f9vEy5lMUmOiaRqls7zhk+GUwrJbsB7RebJO2C
	 GyuiY3e2GSJ58EB+qCAZrWCQn8gHPur0HzmliE/quD+CEYqv5zp+ErraqlrCfRnsOe4jS
	 bNLRguT3hDy9rEYpLozWCsr8HiXvl2CQ6OqPZZpD8UWHf0AivAG9HnKy2KFeqM5yWGDM3
	 tlhoIFxc3lAWP5iN8goJhHE2PRTK8QxzHbVJKTeGyY5fntOHGdc0Mhq+XJIyNY+7TsSS2
	 ACL7hqZ+v0SHLgz37YCx1fxPkv9QIpDZJTVze/aboMrP3vleKkuOrQzd4Qx2AChBbGg==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793717477;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=p9M6+NDJa47KApLPVPzLruAe6VMkp6VfveB+0/ITQfM=;
	b=N/bMRy6ZsOjDK69/QKhUJUn50JIpUYgTIteneJj0s1ZsXbqkhbzDHvb7sUUE1MZn29yr
	 coRGtZ9Kd+FzF8WSmElwLndm5pgktEJ5y9p7PO7azI0sVYzxAv46TBv6VG9otgp4jChh/
	 zTBaMiGhdXWGng/uJxRW++JFCqLKSWeTIP90uhWNhxURFYN9qRkX6dnxJFonr6yIqe24T
	 LIXnIB7qJxGkxRxrwq6bCbVFTYjvDjhgGvqkzsnguU0gduMstJE2X2iwgyuGV9sejZv/d
	 JiSm43Xx27y5//5KiotUJFh6yVYrt5eZPPnMF+pZxT0ZaqSGzVivhzY9bl4E/czsl3Q==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793717477;
	bh=p9M6+NDJa47KApLPVPzLruAe6VMkp6VfveB+0/ITQfM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=r22q3/AtN+02oKVH/o786uSrvAkRJLuFASLce4YBeIcFIvxbRxtqu/9NVIhXR2WSh
	 X6c7o7U0rqbvWQHDM2THSom41eogLKU08vWQkhFufDNmKhBFdkZ6nYqCqoqLJX7UrH
	 oNslaQNIVvm80826WKkU3gJUsyIRnB5Ygm+rrU9rmgrWJNp0QNF1FFxLXzokHujDFM
	 dKjxPY7OMvv8VW55hXtsNItjo6GN+ybXe6X6uQLwGpa3vWXN3GaC984meYsinrltUW
	 WZsaJJCFsDI58+Gn9LhUjZ2rxNTVIrp0vNcfWVDaEm8Hj/oQD2os5EES04R6WsgYZw
	 lDjnEKQwZAP+g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id E72156070F;
	Tue,  3 Nov 2026 14:51:16 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists1.osuosl.org (Postfix) with ESMTP id 59E85A5E
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 14:51:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 40076400FB
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 14:51:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id B0PakZFF0xaT for <u-boot@lists.u-boot-project.org>;
 Tue,  3 Nov 2026 14:51:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp2.osuosl.org 1ACF240068
Authentication-Results: smtp2.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793717474;
 b=QvW05MeFsKbBIST6RP+Tm91H8z1Xg0YdAOidIusD0ZV+hCzQA3Zr4tgiGuArGc1BPKbY
 IU1pI+NeOKKboD5ZChQFni3soSaXaKxAUWRezym5WAvL+ipjaT5rc9pun+JxCuqsROcYg
 DnuLCLgntJ62UW2EIV59QY3lcbkJZkWXmrWvXXvzL785kgO8BwJCr66HY/ZpaZHAjjPmR
 c6tpM1+02nT7kL/e7wa+hkhxQQSDoOMOqDDzagFF/BgPApho+8mK5HJdufAMuQ882lIpl
 qfD1DdywHZ7yTlx5Wf6cIIfACSZMQvM2nq+ag2Miz2l0FrhBEOGBEUUrKE34QFooeJQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793717474;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
 In-Reply-To:References:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=p9M6+NDJa47KApLPVPzLruAe6VMkp6VfveB+0/ITQfM=;
 b=hewMijd0y6kANGKz1nINAMS8aUO2nyd/O+8TFj/i27LweAZBncOnFxiRHFS82F5vgYmR
 6bCJ+CkPz+MKmUCx3G9DeKPXiVMCT4ZuI2wqDpIXZVhPrAzjhguHJoYIGaRxbe9Fq9I2I
 PsYwrNjUKYNL/IQSxVltIIwF63KUlb+3BSNZf3z8puEN2dMd+DP7aDKkRLUQjY3XqysYb
 I9GXz/oMFJK8xU+3Fm9c3G105mDTs5UfbFuzSNp9tfYE7uI2uxGnGuwFP7hqkRp/SYbkK
 IvHbizUNDmMmXS3GKrRBBH8QsUcP2g9HjwGtqruIrHKhybWvqFXMhi8JYBRPyZx9urQ==
ARC-Authentication-Results: i=1; smtp2.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=UlZulooQ; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=xlGTNOV8; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=mainlining.org header.i=@mainlining.org
 header.a=rsa-sha256 header.s=202507r header.b=UlZulooQ; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=xlGTNOV8
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1ACF240068
 for <u-boot@lists.u-boot-project.org>; Tue,  3 Nov 2026 14:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1793717459; bh=p9M6+NDJa47KApLPVPzLruA
 e6VMkp6VfveB+0/ITQfM=; b=UlZulooQDuK8KCPmDmx2L6VviNSmmbW5pa2PCjhL5Kr8JadiuF
 F52RUQ0un+2AWJUB3HDawf9GBgs2enkvZY71RkWphhqL00oWMf/2LhqFxafSAqHNCHniY9N1+E8
 EV6rzRZ99xvhMYQwfhhV/y+pA5U9khLSCMFHS8rIwxKXx0COf+qlPCiPowRIcULOpv191KB/4T0
 7w8F5ELp8G/uGrs5MwlP/cuoJTQVbhCGZ097/d18qlH6zCrb3f7Sh3UOQRnMRU5/lRUmBSAgSdD
 P6gUzqJ7YpiOf16GRFQBh6BkjPWyAi7xKVdFtIUqBeRIdVdqGnL02iR7NmaIQMeoQZw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1793717459; bh=p9M6+NDJa47KApLPVPzLruA
 e6VMkp6VfveB+0/ITQfM=; b=xlGTNOV8creArHi4byhoQfRcm/NxxGq4gRI18vnumtmPw2O3eh
 iYxE4N2cakfwX8y6xAjk/74eX3ZO7XVrByDw==;
Date: Tue, 03 Nov 2026 14:50:57 +0000
From: Bradley Morgan <brads@mainlining.org>
To: Tom Rini <trini@konsulko.com>
CC: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 u-boot@lists.u-boot-project.org
Subject: Re: [PATCH] MAINTAINERS: Update my email address
In-Reply-To: <20261103144513.GM3309461@bill-the-cat>
References: <bd82ee029f9df32b85f4a1c90016fe98852ba92b.1793711640.git.chleroy@kernel.org>
 <AD60C4C9-70D5-4C31-B773-86FD9114C1A4@mainlining.org>
 <9D4F1FC7-573E-41E6-96DD-02397083F21E@mainlining.org>
 <20261103144513.GM3309461@bill-the-cat>
Message-ID: <E2526683-A39B-4D5E-A224-7A5ADAF7BBD4@mainlining.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
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
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 3 November 2026 14:45:13 GMT, Tom Rini <trini@konsulko.com> wrote:
>On Tue, Nov 03, 2026 at 02:35:17PM +0000, Bradley Morgan wrote:
>> On 3 November 2026 14:27:50 GMT, Bradley Morgan <brads@mainlining.org>
>> wrote:
>> >On 3 November 2026 14:03:07 GMT, "Christophe Leroy (CS GROUP)"
>> ><chleroy@kernel.org> wrote:
>> >>Some people have reported christophe.leroy@csgroup.eu being stale
>> >>from time to time.
>> >>
>> >>Change to use my Linux Kernel address chleroy@kernel.org
>> >
>> >Thanks a ton, I'll merge this in coming days to next.
>> >
>> 
>> Btw: if anyone else would like to merge this to their trees please tell
>me..
>
>Minor updates like that are fine to take to main and then PR me, but
>once you've collected things up or it's just otherwise been a while.
>These changes fall in to the category of obviously correct (on review)
>and so are safe to put in the release at any point.


Thanks, do you mind also taking my additional maintainers update(s)?

the regex and the tree addition if that's okay with you? :)


>
>

--- Thanks!
https://lore.kernel.org/all/EE579805-42F2-4C58-B752-F28779EEB717@grrlz.net/
