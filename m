Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AFB5C79FAD
	for <u-boot@archiver.kernel.org>; Wed,  9 Sep 2026 04:38:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BFB3A406F5;
	Wed,  9 Sep 2026 04:38:06 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id hBNM8UgBivPk; Wed,  9 Sep 2026 04:38:06 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 98107406FB
Authentication-Results: smtp4.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1788928685;
	b=kTAR4zFwTylf0P/aop7BcnixwPasfCFbKVdcQNelDLKLU2wRrbwfrITcGD2jQ0EKrcBJ
	 80lVVQ8iMrVsjHR8UNDdTx/m4DqbanxhfmLsYljer3qAOnspRkoV0OAjv6eaXHBU/SR9s
	 08b14glgTriu943IV6xLTN80dDtecHFgWH9Je6hqO3MsZ/U+e3GStXBmIhLQWn43jE1dh
	 qTs5HglwhXbVX4iGKA8pyHabRG2MTNoUOcFXGZocZvgUhAWWTk0gc0RPtL4IOjaCcgfek
	 T/fNOyT0rgxnQm1GAag9EwGEd7yFYrRJ66cS/hzcjGsfjYXEqyx28eiZJeaevoLzIuw==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1788928685;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:Message-ID:DKIM-Signature:Date:MIME-Version:Subject:To:
	 Cc:References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-MBO-RS-META:X-MBO-RS-ID:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=FKffRpKr/hksbnDq14Uu0Q4FxuAet9Oc7iO92fcu38w=;
	b=Ne3BP8FVzo2e7d+NiCmVmMe83bY5Kcb7XexLyyxq2lzUpVh8+wG6kOiBcTl+9+SD6Td8
	 1Y0Nn/y+z2mRZRcFQc+gV5/87K3kSnu8l7v0nG4MeuJ9L4BoWMlOZobLrjBe6SZUcIBBN
	 SEx8k+dHROw+uiRdMnNMMLShuvYeHQqTSsDD8Tt7leAi+8AodwHqema+8Jaz2LhtT0fjj
	 w3gpyK7xCDwg1aScLNNYwX2G2WPq1lI0mD6cZ8f8llmc9/J4si97NvFiN3SeW5T0ns/1l
	 ETSFhu+K004VjhxExiFAmVhHg+Z7Ga1MDpm7npglKubN0hP43Ckddxwe0p4GBY4YgbQ==
ARC-Authentication-Results: i=2; smtp4.osuosl.org; dmarc=pass header.from=mailbox.org;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=Xg3a1Q9Y;
	dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812 header.b=dySNj3i3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1788928685;
	bh=FKffRpKr/hksbnDq14Uu0Q4FxuAet9Oc7iO92fcu38w=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=J6Oz/RcFg4ZEJ0fUtPM40MqPuBhaK40kDDaA5c152a/a9WBy3mauBrHDKn/OGFphr
	 06VTwVniC0kDE7X6hNKfnWKgI7ZJ4boRInFMkAQ73NMd+4f2TfEWAdG+2XsUizumud
	 nqDfC01hQdgehZ5MUHtvbZpB/0IKx75v5Z6jwrOXZGFPXxQWUyAT/UT5R99NrjrtFr
	 Gnm0pMMD7UjUJXTyC9+Ui2A4VHE8YYqw2eOsRsM94FfTE+86+7+hIQAzVragfwOQm2
	 HHJNWS0bAft8JYHI1k9JdCQ/hL3tt7MHhSQBu/JulyeEVOmCnhCzsucoUp2oByXQ5I
	 O3jw6RnlEYs6A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 98107406FB;
	Wed,  9 Sep 2026 04:38:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists1.osuosl.org (Postfix) with ESMTP id 6A4B62E3
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 04:38:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E8FE9406EE
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 04:38:02 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id vZS7pOyfZxDz for <u-boot@lists.u-boot-project.org>;
 Wed,  9 Sep 2026 04:38:01 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.0 smtp4.osuosl.org 043D9406DD
Authentication-Results: smtp4.osuosl.org;
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1788928681;
 b=F+8/ulzyDFdagdHUDSNQEppgWO7ZavRIfYRt2nKnC8n+pJSGhy1uDAQFJ88D9nSslD+O
 nOvfIM4lreglE34cloMddB3n+OgpGvHP3xg5+TrJr2D7tMk8bob6ZrPnUJOTWVMiRM06e
 rGkDTWaOWLUVgBJgpBQJE7wMLZDPRWkqtaqr7nvHlaxR+mGCGZ5YZ0HqSmLvZl/gBieuR
 0ih+BN2mUUjGmBQc7mWvQNqjQ74UJTib6w10MkrWvf4O6ZW9rcbYuU18X87UoQC65Bek0
 6fxWuaqOULcC+k8pVMjdbxN9Z0TQRA3TNUuH3Eu1aklZD69pe7tZko+wZ3uJWSlDDDA==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1788928681;
 h=Received-SPF:Received:DKIM-Signature:Message-ID:DKIM-Signature:Date:
 MIME-Version:Subject:To:Cc:References:Content-Language:From:
 In-Reply-To:Content-Type:Content-Transfer-Encoding:X-MBO-RS-META:
 X-MBO-RS-ID;
 bh=FKffRpKr/hksbnDq14Uu0Q4FxuAet9Oc7iO92fcu38w=;
 b=B/3BbDX5p1TSsVM2sEJZ+NtN18G8LDkevHxzGYqIoWOdQLGgJ5il4cvqbKE4KveR3AKf
 IprkwgKSPfRUyzyOqPigawnzFDKdlS4psE+zkQJcQ7Ij9FiuCXyi+cpKTY2W0ATJvlAVF
 qWBqclSDBz+nlMQzPxwIEI4KLwbqyemGF7fpekkpaTLJzlMpKPSHBg+H+/xO6Hbqefxma
 DHQqKTszBP/t8nQSOQGRPa6EcjUaP7bCenoyqEMiCwbOIcNLH11Y7Qnfr0MdMvKbfoOmA
 TkWaKTrYeUZS+M4o8cbhiac3nEVzEobIPSLt8rLMd2pbGLcJL8tHceiJ6f6ePi57sHQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org;
 dmarc=pass header.from=mailbox.org; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=Xg3a1Q9Y; 
 dkim=pass header.d=mailbox.org header.i=@mailbox.org header.a=rsa-sha256
 header.s=mail20150812 header.b=dySNj3i3; 
 arc=none smtp.remote-ip="2001:67c:2050:0:465::102"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2001:67c:2050:0:465::102; helo=mout-p-102.mailbox.org;
 envelope-from=marek.vasut@mailbox.org; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mailbox.org
 header.i=@mailbox.org header.a=rsa-sha256 header.s=mail20150812
 header.b=Xg3a1Q9Y; 
 dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org
 header.a=rsa-sha256 header.s=mail20150812 header.b=dySNj3i3
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org
 [IPv6:2001:67c:2050:0:465::102])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 043D9406DD
 for <u-boot@lists.u-boot-project.org>; Wed,  9 Sep 2026 04:38:00 +0000 (UTC)
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4hfp2Z0ytQzKv7X;
 Wed, 09 Sep 2026 06:37:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1788928678;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FKffRpKr/hksbnDq14Uu0Q4FxuAet9Oc7iO92fcu38w=;
 b=Xg3a1Q9YX7f3DMMv/Ppxfm4kqfuaUROek0zP+zk35Rbgmyb/K5ky/7KIb+dqHxgTN8dE+Q
 kH+Tx/gPrdDg/OjZmJXAvGVD19gzNBR/X6zrs5pL7l//E563G62XCEwMsvlaMXEDoDNTaT
 l/FW++f6LpPhFyHedbAStoZFK9b/n943FpWqLzH+9t0ehMAYxCYHKDmSYm5P95LA1r9GJG
 raTuayyJ3VNi9HnMmUBN1h9g4J6hSfBX81lusREbOlNYDWqAvfSsegicy5aBuTlBahILlN
 MThIn4vc8P4KGBQf/NZ4d3p8D+cTcEbtGx/ITjmBdf559wG/JFOlDBwPygSiDA==
Message-ID: <5eb78c5c-aa93-402d-af02-46137991f883@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org;
 s=mail20150812; t=1788928676;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FKffRpKr/hksbnDq14Uu0Q4FxuAet9Oc7iO92fcu38w=;
 b=dySNj3i3QvaPoBFovCvow+dUgEHSKk30b+cpen3Gp0KizuUR+SLxAZV0skLeul1+KZqnTW
 /jdPmcpoZUuFmLnDsmyQNB1l1wEbS+M/WUe3roGJw2OXHOeb70SqvOpcFhIErWY29iGXXp
 zN5WKg6oBM/pZcFiVNa9kYi5tqg6ynELg/iLVtBxNYU0x5/m5Er9Kpne3NIY1y/ft3tYua
 J5gpGBORmY/rip4KmAR8GPrfTlk1kW/2VOEdgLV1cjtucpr8HEpBtcvyQbUptxrsF8fzeT
 L2N2gi/z1iOlAHpCbcvTCrjGzcvepS016otbF8rAVlTsBI4DUnBL3riM1Em4mw==
Date: Wed, 9 Sep 2026 04:51:13 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v2] mtd: nand: add Cadence/Evatronix NAND flash driver
To: Ralph Siemsen <ralph.siemsen@linaro.org>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Marek Vasut <marek.vasut+renesas@mailbox.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Brian Sune <briansune@gmail.com>, Johan Jonker <jbx6244@gmail.com>,
 Tien Fong Chee <tien.fong.chee@altera.com>,
 Phil Edworthy <phil.edworthy@renesas.com>
References: <20260814-rzn1-2026-10-nand-v2-1-7aadfa5ca3d4@linaro.org>
 <3ed59460-f04e-4eff-8839-bc766fe52292@mailbox.org>
 <aoBcTpC7KNDuqSpV@maple.netwinder.org>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <aoBcTpC7KNDuqSpV@maple.netwinder.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: cuodyeiisd69gok9mot5bf57iprgg8e7
X-MBO-RS-ID: 3afe06f038565507333
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Unsubscribe: <https://lists.u-boot-project.org/mailman/options/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=unsubscribe>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Errors-To: u-boot-bounces@lists.u-boot-project.org

On 8/15/26 2:32 PM, Ralph Siemsen wrote:
> On Sat, Aug 15, 2026 at 12:28:01AM +0200, Marek Vasut wrote:
>> On 8/14/26 8:31 PM, Ralph Siemsen wrote:
>>> Taken from
>>> https://github.com/renesas-rz/rzn1_u-boot/ 
>>> commit/76c8d3bf19dc64697dd964d7f69ccb3f4fae0094
>> Would it be possible to port the mainline Linux driver instead , 
>> rather than some downstream one ?
>>
>> drivers/mtd/nand/raw/renesas-nand-controller.c
> 
> I did try to get that one working first. After a week I managed to get 
> it to detect the flash chip. However I couldn't work out how to hook up 
> the exec_op() correctly, meanwhile cmdfunc() was growing larger.
> 
> So I decided to try the "old" driver which worked right away.
Would it be possible to do what 
drivers/mtd/nand/raw/atmel/nand-controller.c atmel_nfc_exec_op() does, 
import the kernel driver and only partly replace/rewrite the exec_op 
implementation ?

(I assume you don't want to resync the kernel NAND support into U-Boot?)
