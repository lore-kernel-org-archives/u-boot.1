Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6B0606A333
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 15:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=YrkdcAwc;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b=cNCSaa/0
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 4C8CF40946;
	Tue, 10 Nov 2026 15:12:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XUPcJesnrBWT; Tue, 10 Nov 2026 15:12:14 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 7F35040966
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794323534;
	b=otrZvsevsV80os+V/Yzdft5B8nrm+Fer8UJs2z5Q30o20/P9iG/XEMKr2y++0wIStF1v
	 5G2vAqKr0UVn8OdwebhRfzYoK21/Y9/+biEL5P7UoPp2gCXOQ44BqwCaxDaOfmocW5xBs
	 d1ipGWCsYgw1Zc4Gzu3128J0CdeCfvNCMnP3fLaH2cprv31tHwxZzTy6Ay70OkwwWQALs
	 0Ltn5Ih5e8VGP3Ss/KQhEYMWVfaOYF0F0KwtnIKlBZRGn59H6bKNxhpt3enFrf5Xbd7dr
	 rv2eLBWnsCfA2f024pwOYENa3F60wTULzncD2yTqKMcv42whbdV9d3Po8CzElCQLURg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794323534;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM2-Signature:Message-Instance:DKIM-Signature:X-UI-Sender-Class:
	 Received:Message-ID:Date:MIME-Version:User-Agent:Subject:To:
	 References:Content-Language:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:X-Provags-ID:UI-OutboundReport:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=rmTt0/BBCl1Pp7L/iL4/0dSSdNOKWRZDDe8RIDJkcUc=;
	b=icFBfttL6A7feL2Gc34Rv+ReK847KgT1ReqlAMNmURDWWpIzDZ4s8VHZcEVRQiCANmq1
	 m9qRJLuloPpEY2p7GbSLiJXmJPStnaoPTpog2xrejGoxApbhytJQ8xA9ADw3w14kFBXKB
	 unAvb4dsP+iTwL7Jcd0vFtQDUltjwu284g/bPiD36jy1DDn1KGUZb4cFEeE/VhH1xk+lI
	 dNi8pF3y13Cv2wmzWJGQlwRHmqKHi7Z40uzFloOhIWOVNEacWdrPLPoQ82GxgytQvoGdj
	 mKn9T2m3sSqfsejD9ldxVI4yF4Uq72xr+sfdtG7Szp0QpZDR+WBoZxBRe+uhLld8Wlw==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	dmarc=pass header.from=gmx.de;
	dkim=pass header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b="cNCSaa/0";
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794323534;
	bh=rmTt0/BBCl1Pp7L/iL4/0dSSdNOKWRZDDe8RIDJkcUc=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=YrkdcAwcbAmdccyz1GxA5DpxC1UfBqNl5A9FiOW1kuTR5VHnb0EQSOfVym1IP9tXb
	 HF77kBX0bmQw6ZDhO26i428lr+KQR4YQ84XWwP3GNZRrN1aPDVXuXbJvq28oEoIQnC
	 nNqhpiGxKcYd/T35iq9TEvQNd00vCYFwKusQgWGVj+KoVkfia6wPwyJaBRM5UW6uV3
	 Yp4OWlRhlgdLAUnRZv+Mtt/V/sdBIm/x9fY7RH8+ZL+QQEV6kBiahZw2ewhlG/Jpra
	 2vIztEyBSO6LzoNkF+9Dd5h/IJ0L7bZ7bHnQSGan/1WzKJqKWjfqRF+H2mQR7O//zY
	 FhVarjF6akzxw==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7F35040966;
	Tue, 10 Nov 2026 15:12:14 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists1.osuosl.org (Postfix) with ESMTP id 9F2051FC
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 15:12:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9095240966
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 15:12:13 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id qNYB5PSfBxHY for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 15:12:12 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 2019A40946
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=212.227.17.20
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.17.20;
 helo=mout.gmx.net; envelope-from=xypron.glpk@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp4.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp4.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=gmx.de header.i=xypron.glpk@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b=cNCSaa/0
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2019A40946
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 15:12:11 +0000 (UTC)
DKIM2-Signature: i=1; m=1; t=1794323529; mf=PHh5cHJvbi5nbHBrQGdteC5kZT4=;
 rt=PHUtYm9vdEBsaXN0cy51LWJvb3QtcHJvamVjdC5vcmc+; d=gmx.de;
 s=s31663417:rsa-sha256:fWGuJMpfdjXGhs9LSyOP/diRGuJe
 xDi9AQjde/hQpTUtO0Tj+rE7OJx4l8jGXfFa24JFNEgVmAtq51PXKWfZC/PJAfig8GZZEUnqdEX
 PGSpsiHoY/MLSstQeuPRKaQRnJJEWxSNnW1vooOsoNd62p8xix037zCTC4QXbTAr6+S2pVD5INE
 /T6u6G8Yo8yuz2C2BxJyGtZVsJz3PyIxSggmTgI3Md4cb6Zkg0i27gNdqSlDGJiKS8088YLyXXo
 MCzjqm+SSzQIOQB5roXzqw8DQQXczGD5N1Us0sYz9pYCADs+qlzd0OuTMGEB1Kx+KrKl6BHlU0M
 j+3oR82ogerfTA==;
Message-Instance: m=1; h=sha256: MIZTt/IcUmIXUFaj37KdBdOhUwcNEYA2z1Pa94HU7QM=:
 rmTt0/BBCl1Pp7L/iL4/0dSSdNOKWRZDDe8RIDJkcUc=, sha512:
 UF5ofA8RsI1b15bUuX7IKyWnSuyic+uAYdkB69rBzJEhHGocDCm6R+WEi0OVUrlSAAlx/YqgTRkQOLGk8yCX7A==:
 yAuLwWgadBJ75niYDRDndNk1TYgh3mE13mk5VfJjVGJWB5K6vljxWmZraYvUUS3FQMWaKhYQVXMmbI8NwnRkAA==;
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1794323529; x=1794928329; i=xypron.glpk@gmx.de;
 bh=rmTt0/BBCl1Pp7L/iL4/0dSSdNOKWRZDDe8RIDJkcUc=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=cNCSaa/0i28ziBmzzBfTPPxruJUYsFl7/X3VxZeak+haACbz1fckxuyCb0AXnRbh
 /XKpBLjHZF0CzEFSeIMjYkDJR4XzhgA/ur/I2cCXlqZZ0w2dNW5R0EZN2N6H8C/W9
 OQfmdjrKmeWa2XhpUMLj3yVF1GBABW6OlMLYmSvHoOTz1bVS+mDFE9Pi8QicosWLj
 UfOXu5jCQ4lVEAXYKvnV1ic8BkuNkfPBlruJjoo3AFgEBnzojI9NIxedW8dgAH75G
 Kty1LnddryocvhniiO2JP9g9umjizLjpPayUzapK/HkeJU7HY2b2x0Ut0ctS9DOjJ
 zb1NN6DSqn8tp6EVIg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MeCpb-1ws0nW1bb5-00mGri; Tue, 10
 Nov 2026 16:12:09 +0100
Message-ID: <b415d946-eda6-4ac8-a8ec-4b00a379effb@gmx.de>
Date: Tue, 10 Nov 2026 16:12:08 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFH] Writing a project Code of Conduct
To: Mattijs Korpershoek <mkorpershoek@kernel.org>,
 Tom Rini <trini@konsulko.com>, u-boot@lists.u-boot-project.org
References: <20261103172036.GS3309461@bill-the-cat>
 <xhkdbcxsdvux2.fsf@mkorpers-koolstof.csb>
Content-Language: en-US
From: Heinrich Schuchardt <xypron.glpk@gmx.de>
In-Reply-To: <xhkdbcxsdvux2.fsf@mkorpers-koolstof.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:DQT9/3uY/NJFVuaUfeWbGON7UEdNSf6YTN+Qs938Zaz+Pc4VWNQ
 n5VgDeEmZyjgt6oIbhKYMxHR+BovASkE4jmhzy6YeFoT+PfZ6xAMAC2MvETt0vTggmzL5Z1
 0dhY640DaK+85yx+dV//IrMdSaSt7nlkB8pYgGMQwC25zewvRqVmqPVHBhWZI2RVNzAepuS
 nLt3r7njHXxoCgBvPzwnA==
UI-OutboundReport: notjunk:1;M01:P0:QJexfgP+aeU=;Q1BabjBbO/Wm7629qDszdnSjFWS
 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
 0RXssoE8HT7vK8bNZnWc/dZ
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/10/26 11:32, Mattijs Korpershoek wrote:
> Hi Tom,
>=20
> On Tue, Nov 03, 2026 at 11:20, Tom Rini <trini@konsulko.com> wrote:
>=20
>> Hey all,
>>
>> Getting back on track with project administrative tasks, one thing I
>> have talked about the project needing for some time is a code of
>> conduct. In my mind, the best starting point here is, are there code of
>> conducts in other projects that people use and they feel would be a goo=
d
>> example for us to adopt? Thanks!
>=20
> Have you considered the Contributor Covenant Code of Conduct?
> That's the one Linux uses, see:
> https://docs.kernel.org/process/code-of-conduct.html
>=20
>>
>> --=20
>> Tom

https://policies.python.org/python.org/code-of-conduct/
is another reasonable code of conduct.

Best regards

Heinrich
