Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A52606A326
	for <u-boot@archiver.kernel.org>; Sat,  7 Nov 2026 09:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=i8OoOoP4;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=pigmoral.tech header.i=@pigmoral.tech header.a=rsa-sha256 header.s=zmail header.b=mgK13a9e
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 20C3940603;
	Sat,  7 Nov 2026 09:07:33 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id wlaC0oITaCDh; Sat,  7 Nov 2026 09:07:31 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7D8C2406A0
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794042451;
	b=fZmKaZNjaxsFaO5t7vWC5JwSj9DBh9uG0V09uNnh5CPPnCc9pvIk1zGrTijOofooljMW
	 5XA7dtDows87Bvj9nMfly6LRF+CEsmjRbgmWTeb/sA9XLLZWEi6PQAawQ0n4oZf+oqbPp
	 pFe/UnaSK5bwJ/z4hu8ZsyZuPRq4TBOPp3nEJKyn2N+6DuJYA7CLBJEGOGsaBzp3qgT/8
	 gqXf3Tf/IFS9iMXXu/9UqeswcHv5dlOxHKtInk7wg99ggE5r2HRUSVoelyERAg/ElbxbZ
	 z7eApkr5a2BhV3D5vZ546ChK7woDA/ko4NFHCOz+Wq7T73uYlvzbGAhV8F/GMuRDpfQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794042451;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:Received:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Cc:Subject:From:To:X-Mailer:References:
	 In-Reply-To:X-ZohoMailClient:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=w+zz8N0oIMAIxZI1Wlz1BCwsbz3bf2qXyCduT0oJ6Wc=;
	b=NtFEVvZvZkmlu8iJN2toUfp1lujve4WoG7NbR+03tdGhIUMpBpmzpI+pR9DPU1GTEDKI
	 vU6vQjhLeqOAydBqXRtOijKL8J6n+u0lLE8wPwHg9GpFk3flPOv8Aq8dOctTqPBhxEl3O
	 09o87ONUjbs8y8dBDypP/bmYUZ0Bv1nN2Lg7qURw7wOx5zJzTSSowwWfGzkH5TaeEtzPb
	 V7C5RhqLg5q8EfVJK0uNjtRHEu1694s6d4oAcmcAFdyKvTLDFnMKnLgofmMnuUFDqYAn2
	 FJfMATSL/ljuQCtnscZRyAnh7gpJQ7H6d+PhMkO7axB4cPXLE8cENagTgaMpp9Lf81Q==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794042451;
	bh=w+zz8N0oIMAIxZI1Wlz1BCwsbz3bf2qXyCduT0oJ6Wc=;
	h=Date:Cc:Subject:From:To:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=i8OoOoP47SO0j2eWQkZP8YGeRisdtYgyQGFNa7SU/h2k4SwVwnF9xUOV4JAkeCfZM
	 YgDqWPxjHR87n/+EU18EH22xbFzcHyKP2uxZZRzkx4HbchAf3F0VE+9I55OdG/ez32
	 Yv9Z6wcHWE0+eikcHRaoA4axYHtyrLqF3I0D27F6bEhN08ZssUj6YwTUQkv1q77BB8
	 M5xmH/o624IE+0xqYPaTGxH2hWSQjQ6qZc0oqO2ToOfYKmdEPwWGm81K4Bq5ilCmbW
	 eojk4v7tBBP0brVAElHk8/1W1Q/N3gtiD450ZOQeT3GOA+5SqNf69JugRkz2XZnGZU
	 3BZxO84LDBs/A==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7D8C2406A0;
	Sat,  7 Nov 2026 09:07:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 6D27634D
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 09:07:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6A798606C0
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 09:07:29 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id x4Hc4rXG1E1w for <u-boot@lists.u-boot-project.org>;
 Sat,  7 Nov 2026 09:07:28 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 11DB8606AA
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0
 smtp.remote-ip=165.173.180.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=165.173.180.15;
 helo=sender6-op-o15.zoho.com; envelope-from=junhui.liu@pigmoral.tech;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=none (p=none dis=none) header.from=pigmoral.tech
Authentication-Results: smtp3.osuosl.org; dkim=pass (1024-bit key,
 unprotected) header.d=pigmoral.tech header.i=@pigmoral.tech
 header.a=rsa-sha256 header.s=zmail header.b=mgK13a9e
Received: from sender6-op-o15.zoho.com (sender6-op-o15.zoho.com
 [165.173.180.15])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 11DB8606AA
 for <u-boot@lists.u-boot-project.org>; Sat,  7 Nov 2026 09:07:25 +0000 (UTC)
DKIM-Signature: a=rsa-sha256;
 b=mgK13a9elzIU0RAHDUggTE2rnN5pd8b5UnWEqIDDlXAmv7l+Mfe/MVJXjInerynwWNWbmUrNJEMkZ49W3+vetiJdhRuQ77K6i36CTCqD4IKb+R+pZlyGEXMNyTlelHWi40jSEbUeVpz5y/saXxbweZtplCpKT4QfuqYOYJrxL7k=;
 c=relaxed/relaxed; s=zmail; d=pigmoral.tech; v=1;
 bh=w+zz8N0oIMAIxZI1Wlz1BCwsbz3bf2qXyCduT0oJ6Wc=;
 h=Content-Description:Content-ID:Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:List-Subscribe:List-Post:List-Owner:List-Id:List-Archive:List-Help:List-Unsubscribe:MIME-Version:Message-ID:Resent-Sender:Resent-Cc:Resent-Date:Resent-To:Reply-To:Resent-Message-ID:Resent-From:Sender:Subject:To:Date:From:Message-Id:Reply-To:Subject:To:Cc;
Received: by smtp.zohomail.com with SMTPS id 1794042414325700.1024091568044;
 Sat, 7 Nov 2026 01:06:54 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 07 Nov 2026 17:06:46 +0800
Message-Id: <DMOUYFJ5XULA.3REWL8U5IZKY5@pigmoral.tech>
Cc: <u-boot@lists.u-boot-project.org>, "Yao Zi" <me@ziyao.cc>,
 <u-boot-spacemit@groups.io>, "Tom Rini" <trini@konsulko.com>, "Tim Ouyang"
 <tim609@andestech.com>, "Leo Liang" <leo.liang@sifive.com>, "E Shattow"
 <e@freeshell.de>, "Huan Zhou" <pericycle.cc@gmail.com>, "Eric Chung"
 <eric.chung@riscstar.com>
Subject: Re: [PATCH 3/5] riscv: dts: spacemit: k3: Add SPL device and image
 descriptions
From: "Junhui Liu" <junhui.liu@pigmoral.tech>
To: "Yixun Lan" <dlan@kernel.org>, "Junhui Liu" <junhui.liu@pigmoral.tech>
X-Mailer: aerc 0.22.0
References: <20261106-k3-ddr-v1-0-1e60e1d78020@pigmoral.tech>
 <20261106-k3-ddr-v1-3-1e60e1d78020@pigmoral.tech>
 <20261106065916-GKC249737@kernel.org>
In-Reply-To: <20261106065916-GKC249737@kernel.org>
X-ZohoMailClient: External
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Yixun,

On Fri Nov 6, 2026 at 2:59 PM CST, Yixun Lan wrote:
> Hi Junhui,
>
> On 00:40 Fri 06 Nov     , Junhui Liu wrote:
>> Add the DDR controller node and mark the UART, I2C EEPROM and required
>> clock and reset providers for use before DRAM initialization.
>>=20
>> Add a binman description for spl/u-boot-spl-mkimage.bin, combining SPL
>> with the external LPDDR5 PMU IMEM firmware and wrapping the payload in
>> a SpacemiT K3 boot image header.
>>=20
>> Signed-off-by: Junhui Liu <junhui.liu@pigmoral.tech>
>> ---
>>  arch/riscv/dts/spacemit-k3-binman.dtsi | 24 +++++++++++++++
>>  arch/riscv/dts/spacemit-k3-u-boot.dtsi | 54 +++++++++++++++++++++++++++=
+++++++
>>  2 files changed, 78 insertions(+)
>>=20
> ..
>> diff --git a/arch/riscv/dts/spacemit-k3-u-boot.dtsi b/arch/riscv/dts/spa=
cemit-k3-u-boot.dtsi
>> index 352e85e7de8..0976b2647b5 100644
>> --- a/arch/riscv/dts/spacemit-k3-u-boot.dtsi
>> +++ b/arch/riscv/dts/spacemit-k3-u-boot.dtsi
>> @@ -4,3 +4,57 @@
>>   */
>> =20
>>  #include "spacemit-k3-binman.dtsi"
>> +
>> +&{/soc} {
>> +	ddrc@cb000000 {
>> +		compatible =3D "spacemit,k3-ddrc";
>> +		reg =3D <0x0 0xcb000000 0x0 0x01000000>,
>> +		      <0x0 0xcc000000 0x0 0x01000000>;
>> +		spacemit,apmu =3D <&syscon_apmu 0x4e8>;
>> +		bootph-pre-ram;
>> +	};
>> +};
>> +
> I'm not sure if it's a good idea to also move "ddrc" to mainline kernel
> dts, at least to reach a consensus about stable compatible name..

I see. I can try submitting a DT binding patch to the Linux kernel
mailing list later to get the DT node design reviewed and reach
consensus on the compatible string.

>
>> +&i2c2 {
>> +	bootph-pre-ram;
>> +
>> +	eeprom@50 {
>> +		bootph-pre-ram;
>> +	};
>> +};
>> +
> For adding all "bootph-pre-ram" properties, I'd like to see patch=20
> submission to mainline kernel tree, see similar thread for K1 SoC[1]
> so eventually it will get synced to a proper directory under dts/upstream=
/..
>
> But, I know it would take long time for the upstream dts hit into U-Boot
> tree, so a compromised solution is that we temporarily accept this patch
> before the sync, then fix it up later accordingly..
>
> Link: https://lore.kernel.org/r/20261024092558.143621-1-alan.tseng.cs@gma=
il.com [1]

I agree. However, since our SPL support is still incomplete, we may need
to add more nodes for pre-DRAM initialization. I'd prefer to wait until
the bring-up is complete and submit all the required DTS changes
together, rather than sending multiple incremental patches.

--=20
Best regards,
Junhui Liu
