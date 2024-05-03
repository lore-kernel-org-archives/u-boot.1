Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79A03C4345F
	for <u-boot@archiver.kernel.org>; Fri,  3 May 2024 17:18:31 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id CD11E882D4;
	Fri,  3 May 2024 19:18:29 +0200 (CEST)
Authentication-Results: phobos.denx.de; dmarc=fail (p=reject dis=none) header.from=bk.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Authentication-Results: phobos.denx.de;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=bk.ru header.i=@bk.ru header.b="lS/wS0Im";
	dkim-atps=neutral
Received: by phobos.denx.de (Postfix, from userid 109)
 id AF201882A5; Fri,  3 May 2024 18:35:32 +0200 (CEST)
Received: from f132.i.mail.ru (f132.i.mail.ru [45.84.128.41])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 870008829B
 for <u-boot@lists.denx.de>; Fri,  3 May 2024 18:35:30 +0200 (CEST)
Authentication-Results: phobos.denx.de;
 dmarc=pass (p=reject dis=none) header.from=bk.ru
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=24_v@bk.ru
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=bk.ru;
 s=mail4; 
 h=Content-Type:Reply-To:Message-ID:Date:MIME-Version:Subject:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc;
 bh=Y2q7SdGcQoXK7IECz3k1BWMW6gVD1pl0q2c3u3pSjik=; 
 t=1714754130;x=1714844130; 
 b=lS/wS0Imyx0pqTqwAG0NKIeTgLlAc3guz/kcKdVpopvOPbcOAqBRPgheq6b5j4r6Nlt2DTmh4HSHI5VsHViDthBcNKIEg698CTzpQ++NuMS4XksdwwKNn3lA8HxQOg1j6Vu9djmZgeGTmL8w006eoEcMWp9dFBGwe+fvn3cQU/N/PnCI/b5PZG003nFUNV14TQT4mGcJMaifTWfyhOfTd+HGV0VMQ4NK0nF4geJ6c6Nd0LI+CroPdFv6nkCT1Lk9/f3tUMq1Fq2KXnkdbb4L2HCUKdnYkMBxCFuqhS8VzKHJsZwL434NHG2a2FVJZOp5Q0XQ9riuWXEcvMMfRqNTbA==;
Received: by f132.i.mail.ru with local (envelope-from <24_v@bk.ru>)
 id 1s2vsd-0008Cu-GD
 for u-boot@lists.denx.de; Fri, 03 May 2024 19:35:28 +0300
Received: by e.mail.ru with HTTP;
	Fri, 03 May 2024 19:35:27 +0300
From: =?UTF-8?B?MjR2IDI0dg==?= <24_v@bk.ru>
To: =?UTF-8?B?dS1ib290?= <u-boot@lists.denx.de>
Subject: =?UTF-8?B?dXNiIGJvb3Q=?=
MIME-Version: 1.0
X-Mailer: Mail.Ru Mailer 1.0
X-SenderField-Remind: 0
Date: Fri, 03 May 2024 19:35:27 +0300
X-Priority: 3 (Normal)
Message-ID: <1714754127.362500698@f178.i.mail.ru>
Authentication-Results: f132.i.mail.ru; auth=pass smtp.auth=24_v@bk.ru
 smtp.mailfrom=24_v@bk.ru
X-Mailru-Src: fe
X-7564579A: 646B95376F6C166E
X-77F55803: 119C1F4DF6A9251CDA441B2D38DFD73F55335218146E157B9D761581AC578FF4ABF6EAE57C0FACE92452FA073671E37CB119B6F9C07C7DD20B979000F73CA24199950209BA47E511
X-7FA49CB5: 70AAF3C13DB70168C09775C1D3CA48CF1B01FEBA22ADC20FB07C2033C5A38408395957E7521B51C22F7342069CE59A5B9742502CCDD46D0D7B0E78B2725B8D9BCEDC9CE4EAAF844100A2F9E72F20F12F36C75B72B9FDC350B287FD4696A6DC2F5F5C1EE8F4F765FC47272755C61AA17BBFD28B28ED4578732EF20D2F80756B5F40A5AABA2AD37119BCF491FFA38154B6D5E8D9A59859A8B6B737A621A50BC793BCF491FFA38154B6B5C8C57E37DE458B7AC6C5076A9912D9A93B80C6DEB9DEE97C6FB206A91F05B2D41C555F2D7B9B6154C3D1D71B88B02C733995DF9B28C54002ED4CEA229C1FA827C277FBC8AE2E8BEC1C9C6CFAD2A0F5A471835C12D1D9774AD6D5ED66289B5278DA827A17800CE78C592797616C97AB9FA2833FD35BB23D2EF20D2F80756B5F868A13BD56FB6657A471835C12D1D977725E5C173C3A84C31A3F3A3731258CC5117882F4460429728AD0CFFFB425014E868A13BD56FB6657E2021AF6380DFAD1A18204E546F3947CB11811A4A51E3B096D1867E19FE1407959CC434672EE6371089D37D7C0E48F6C8AA50765F7900637ED7DFAFE1016008EEFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-C1DE0DAB: 0D63561A33F958A585B0AA49198AFEE64084DE17807BBE0B05CE014DD3B90D07F87CCE6106E1FC07E67D4AC08A07B9B0D7F4798FD4FA8F52CB5012B2E24CD356
X-C8649E89: 1C3962B70DF3F0ADE2815F1F17DA719077DD89D51EBB77422CCB5A6D6581D03D0776B5B2C279835F17BCBE6708A5A68D02015372BE9702A20A408672F42815027E1AD042BE98E4DD8B498FD88F11BF3B01138E75902258694BC5BA7E65B12B8C406BD9281BAFFD7FF56EEE155D224ED6761738F50F94F48F52EE4E5D9E54FDA44C41F94D744909CEF928695058265B9BCD423D1B1985E0EB43082AE146A756F3
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5+wYjsrrSY/u8Y3PrTqANeitKFiSd6Yd7yPpbiiZ/d5BsxIjK0jGQgCHUM3Ry2Lt2G3MDkMauH3h0dBdQGj+BB/iPzQYh7XS329fgu+/vnDhBqjqmu1ixn/vX0nYIKMuYA==
X-Mailru-MI: 10000000000000800
X-Mailru-Sender: 015BA6FC0EFA223A2FF779ADC1FA9EA927CE76DB2777149BF3EA88155E4265410D6F00561003FD7FCD3005330FC6A00875337F8A33AEB0B393C47C70A49BDF83F8917383379F393CF062231DAA1277BB1BDACF2A725691CE81B060776E3CD07ED6ABBC8983DD6D020D4ABDE8C577C2ED
X-Mras: Ok
X-Spam: undefined
X-Mailman-Approved-At: Fri, 03 May 2024 19:18:27 +0200
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: base64
X-Content-Filtered-By: Mailman/MimeDel 2.1.39
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
Reply-To: =?UTF-8?B?MjR2IDI0dg==?= <24_v@bk.ru>
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

CsKgCsKgCkhlbGxvLCBJIGhhdmUgYSBsaXR0bGUgcHJvYmxlbS4gSWYgSSBib290IHZpYSB1c2Is
IHVib290IGRvZXMgbm90IGRvd25sb2FkIHRoZSB1Ym9vdC5lbnYgZmlsZSBhdCBzdGFydHVwLCBi
dXQgaWYgSSBydW4gdGhlIHNhdmVlbnYgY29tbWFuZCwgaXQgd2lsbCBzYXZlIHRoZSB2YXJpYWJs
ZXMgaW4gdGhlIHNhbWUgZGlyZWN0b3J5IHdoZXJlIHUtYm9vdC5iaW4gbGllcy4KCkJlc3QgcmVn
YXJkcywgRG1pdHJ5IFZvcm9uaW4=
