Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6DE606A31A
	for <u-boot@archiver.kernel.org>; Fri, 30 Oct 2026 14:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=ydcax44l;
	dkim=pass (2048-bit key, unprotected) header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=VWtCacIi;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=BhpWVF9w
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C2F3160AB6;
	Fri, 30 Oct 2026 14:40:41 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id DGF2HkbxM0Ir; Fri, 30 Oct 2026 14:40:41 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org AF244606B0
Authentication-Results: smtp3.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1793371240;
	b=F6U9GmJbLT8vzaUHWJkNh3IR2fq7FxeQ17zw6iiFhRUYwKdhrVwhbvhqwhoUWvAlbsmp
	 p22TaxRpDbv7DrPbzWQ3Vrtw6sHH6xYj0DCAR+c3EQCpX3Qju66jkH+yWOlntwph82qJM
	 fQ5mg6nz1QrfJl9e2F5RtTERtt4j+pljyT0nLylEurDTRBa+vr/06er8nzD3B5+IiQ3Gk
	 PEd8k+pMQOGwcI72XidGObwX+SY2uSV3c8DdLHoJMnsWQ8Eq6mL6DU0BnBE6Uy8E+lMkY
	 +9lGOWLCiQNkP+UvfsQQjAeQp0d577arLZ0HV7OoT9J/L+a3N2XmFozYw32LRpKKv2Q==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1793371240;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:In-Reply-To:
	 References:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-BeenThere:X-Mailman-Version:Precedence:
	 List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=A73LPuF5x5FxjAJHVWU9ydmm4r4oKJtfsi9ORx4dk0g=;
	b=RGDcwap1kd4fcCEGRoxkLGnwhPFtXQtNim9NnKR9EXLGVHCZmqj2U22a2C/P6K5qks9F
	 6gEUh1eHeHuLn4vw0b8ijFbKY2eHKk8iugnM1q9IELVN+fEfjHtdjVAovk8Sh65qvvDJ5
	 iOPHi4Q+VlhR665xWpl0j1pUOyWDU0f79/Ll66N5rpEPBsGQ6N1CQ32a9hCRuGSl+NE+m
	 wIKjTSECvw9ZnkxzVu2dSt+vfSAmDGDWfSFs8AF5n+x9adzmDEus4Auv82QDymRnTwYLK
	 /iEnl0YhGstx40I+O0xhs+vmwhPnZBluXETLrmsu49tHqvnPMASyEJgtvy67PgbDd2g==
ARC-Authentication-Results: i=2; smtp3.osuosl.org; 
	dmarc=pass header.from=mainlining.org;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r header.b=VWtCacIi;
	dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=ed25519-sha256 header.s=202507e header.b=BhpWVF9w;
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1793371240;
	bh=A73LPuF5x5FxjAJHVWU9ydmm4r4oKJtfsi9ORx4dk0g=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=ydcax44lq0NoURPO2y6UiwXlHoKled4uEIqvBBOUgznUpnt5J5fl162LFnEJXitou
	 Im77vn8GLI6OSEmzTswuVpmHnjmiiE/iXR/nVXtCl8zPNg31icAhVOt81tTI7QI37F
	 fSnHNWS3a3aD6FSzePumTusTTCKC/hVZ3GhVlfQ5/DVtRGl1NyLKL/ckYvZ+iIokd9
	 xGbn3Fd1KZx/devw/8IDu4/aqEcesio116FxrQffuBnDtix3WJSjrmQe97Ma9rSkMQ
	 PyS44Zmvjfa7A2wyIV9RdBf8u3qQXylIuSgQQ6ZrZ0MBabdZeaUefIpXNYD33cxI//
	 0Ut/DFnBOU5Gg==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp3.osuosl.org (Postfix) with ESMTP id AF244606B0;
	Fri, 30 Oct 2026 14:40:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 9C4C02AC
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:40:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 81FBD606B0
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:40:39 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id Io_44n_Q_07I for <u-boot@lists.u-boot-project.org>;
 Fri, 30 Oct 2026 14:40:38 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 21C2860668
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=5.75.144.95
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1793371238;
 b=BVFIxoLSFNpbbLeQjt0MDAdnl7oFk3JPDklewE3INrsJ0/HPqljRzmVPgEDPz7GRYLd2
 vY1BYFVRjDuTyEPB4C2FUAI4PkDzuRPzIO8qNF7x4YjNurOVtWuTHBvCZuTo8FRomoM00
 XS/FFT5d9Cl3zcgxaCcN2fRJLCvZs2aLsgCJa5qLS2mcNRSNt/MEze42Pr900mDOf/JcI
 UfBqsvY2RBhAMHL4Mb7r4hPZ9omagRZ+hQdFEmTItMuYN8h7fiC414bxO2jhBZnZlEikM
 N+Io3bCWn8snWZ8HLDv9Sjf9eGAF4zSB2IHsYOGVgePm2DT6Z2FJK+Y89Jwhnejlb2w==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1793371238;
 h=Received-SPF:DKIM-Signature:DKIM-Signature:Date:From:To:CC:Subject:
 In-Reply-To:References:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding;
 bh=A73LPuF5x5FxjAJHVWU9ydmm4r4oKJtfsi9ORx4dk0g=;
 b=npVIoVQ1saAcWjJ0uQ0kthEc5QP2TLPs1XJG1pR8KVlFhTjnYFoN6NlijyyrLUveTRew
 +Cfi4Pp9PJIgR8IXey+32zlREi0l2xOasXhUeLvGCWlN/HeQc24sSqgalhSpdP+eUNZHz
 JYFDsImAm/fKQNV6OPZ2lq6YVDdn2cuqGnsCk1a++LEWQ0vzhYB/Vrv4jrT/3WQDsI2sa
 KsD2AmvXZKbwHh95y57ZLkmKuuMztGDXB8L8pU4TD+ciiviKGCpY2un8l3ZucHUGR5re9
 7k9NzSbGqPmFm9/b65F7tYz59KcWW7i9awpnlMp9EcY4Ob21KMZ10sLQXtpeExAkJHA==
ARC-Authentication-Results: i=1; smtp3.osuosl.org; 
 dmarc=pass header.from=mainlining.org;
 dkim=pass header.d=mainlining.org header.i=@mainlining.org header.a=rsa-sha256
 header.s=202507r header.b=VWtCacIi; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=BhpWVF9w; 
 arc=none smtp.remote-ip=5.75.144.95
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=5.75.144.95;
 helo=mail.mainlining.org; envelope-from=brads@mainlining.org;
 receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=reject dis=none)
 header.from=mainlining.org
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key, unprotected) header.d=mainlining.org
 header.i=@mainlining.org header.a=rsa-sha256 header.s=202507r
 header.b=VWtCacIi; 
 dkim=pass header.d=mainlining.org header.i=@mainlining.org
 header.a=ed25519-sha256 header.s=202507e header.b=BhpWVF9w
Received: from mail.mainlining.org (mail.mainlining.org [5.75.144.95])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 21C2860668
 for <u-boot@lists.u-boot-project.org>; Fri, 30 Oct 2026 14:40:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; s=202507r; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1793371234; bh=A73LPuF5x5FxjAJHVWU9ydm
 m4r4oKJtfsi9ORx4dk0g=; b=VWtCacIiHiHt0lirtm+NgMgXX2TWlBXEFm7WzmlsIUqP//UjPk
 klPKum0FMqpUSS7i0bEozJ+DCswFiZIEOvGpDzO0GV7SE9CBI+GPBwjTrvO8/5BnUX9+DlqeaBZ
 02+FTWgXeIz8AnD43D+Bxf1TBg/jR88I8ovcDmbufzpvTNdEkGFl6HUiRJbvkWtOAW3zqEVT48x
 NkJltWhDU2sJmSgGrBPkLjtOWeiWYgQdWMi/g8XRLLFkUevCL3Xl6y5BvzzMIJ9OJaEHFN4eeY9
 PMyLKRKvG18j7dO6tTlXQ42kf6hVWgcafK6AWVSQG8ZQVZ23BaTck6wKLIDtz88jLiw==;
DKIM-Signature: v=1; a=ed25519-sha256; s=202507e; d=mainlining.org;
 c=relaxed/relaxed; 
 h=Message-ID:Subject:To:From:Date; t=1793371234; bh=A73LPuF5x5FxjAJHVWU9ydm
 m4r4oKJtfsi9ORx4dk0g=; b=BhpWVF9wT6e1oxl1bdBLPJe6uPanlDPWhHQzeK6zzNDOU0mJhI
 Xy/0jqP6hmJPqFs3UivrBCFlDRget4qt11Dw==;
Date: Fri, 30 Oct 2026 14:40:36 +0000
From: Bradley Morgan <brads@mainlining.org>
To: Tom Rini <trini@konsulko.com>
CC: u-boot@lists.u-boot-project.org
Subject: Re: [PATCH v2 0/4] doc: arch/powerpc: add architecture documentation
In-Reply-To: <20261030142436.GK3011578@bill-the-cat>
References: <20261030020832.26572-1-brads@mainlining.org>
 <179332641005.29622.13964170083166836926.b4-ty@mainlining.org>
 <20261030142436.GK3011578@bill-the-cat>
Message-ID: <17235E63-E2CD-4B0C-873C-79418E350EE9@mainlining.org>
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
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 30 October 2026 14:24:36 GMT, Tom Rini <trini@konsulko.com> wrote:
>On Fri, Oct 30, 2026 at 02:14:08AM +0000, Bradley Morgan wrote:
>> On Fri, 30 Oct 2026 02:08:27 +0000, Bradley Morgan wrote:
>> > There is almost nothing in doc/arch/ for powerpc, so this adds a
>folder
>> > like the x86 one, with four pages:
>> > 
>> > - an overview: what the port is, the cpu families, the boards, how to
>> >   build it, the config options people ask about
>> > 
>> > - the mpc85xx boot images: the NOR, RAMBOOT and NAND layouts, and the
>> >   CONFIG_SYS_MPC85XX_NO_RESETVEC and SPL/TPL knobs
>> > 
>> > [...]
>> 
>> Applied to next at u-boot-ppc, Thanks!
>> 
>> [1/4] doc: arch/powerpc: add an overview
>>      
>https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/e6a37f4dfeea
>> [2/4] doc: arch/powerpc: document the mpc85xx boot images
>>      
>https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/3287ff140823
>> [3/4] doc: arch/powerpc: add a PBL guide
>>      
>https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/b74d2c1efaac
>> [4/4] doc: arch/powerpc: add a booting and porting guide
>>      
>https://git.u-boot-project.org/u-boot/custodians/u-boot-ppc/-/commit/0851db824add
>
>For non-critical changes, please wait at least a few days. I'm hoping
>that for the documentation stuff you're doing that Heinrich will have a
>chance to look at them, for example.

Hi, don't panic, I'll drop them if there is issues.

Also, remind me, is Heinrich the Hitachi guy? I don't remember.

I'll CC him in future patches if you like.

>
>

--- Thanks!
