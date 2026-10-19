Return-Path: <u-boot-bounces@lists.u-boot-project.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30ACFCCF2DE
	for <u-boot@archiver.kernel.org>; Mon, 19 Oct 2026 13:37:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0BAF08100F;
	Mon, 19 Oct 2026 13:37:45 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CfMJYu0dNHEZ; Mon, 19 Oct 2026 13:37:44 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 30F2680F9E
Authentication-Results: smtp1.osuosl.org; arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
ARC-Seal: i=2; d=osuosl.org; s=arc; a=rsa-sha256; cv=pass; t=1792417064;
	b=ako1TXCYFNSEfPyD0D1v5FgdFCUTgrRoBK64hIrJuvjWjiRU+9VQsKLeg86tKmsdTsBj
	 1v06COIypY/Djbo+0+PP1MZP9wQgv3j3RG+5zhsERId9mfUBMR/lkm7SxaeXXbKau6/Nx
	 cExnzn9DonCl1bW4Geg5mVvRLn7NA1emwpGqPOC7woGqtcou0vxCLYvA9tijTfakk+hMh
	 o7bzn3ug6oLY8GABw7Zu1zcbBpL1V5rM7mOGRGhTBt2sVJohjaiYircC60abddQ8StkeR
	 HVI+hDNjTBMklem2win59LHI1eSieyWwwzJWC/8TXqRDA/Tl9ZTLccgBg045Ikwid+w==
ARC-Message-Signature: i=2; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1792417064;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:
	 DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:Date:
	 MIME-Version:User-Agent:Subject:To:References:Content-Language:From:
	 Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding:
	 X-Provags-ID:UI-OutboundReport:X-BeenThere:X-Mailman-Version:
	 Precedence:List-Id:List-Unsubscribe:List-Archive:List-Post:List-Help:
	 List-Subscribe:Errors-To;
	bh=wk0tQaP2JtH06WzzQ0gqY6NGaxueAE1zaoKxKiZGQvI=;
	b=TgWqXnjsHHYuWfA7oi4WNPC8p5/15ViTj+Cn1encFnB09LtMJxLAY2qqIYUyMMk6256g
	 fUBATSXEpn0wP6uI8rLBUguZ3m8d+M9Wr6lU3lhv8tFsinQlFjO6BAA7KMm/8zyv0grfB
	 4fuuoXsn9I+AY31zNru4PU4JwNK2BznbgFVg+MyZBGPteGyLDhH4En516LBY1/jqi1xHv
	 5wSmjJFyeVHldo9e9ez3jUXxr871p3iuzNWmZVb9hyoN/uOzxy91fdYLDCQ6N3CJes3uj
	 lAt4AwdId1rfiON4ofp2nyKHKmD/Pz+ROXdf5CL6/2IOvNpdt/agi4NkQDPaAkkGqlQ==
ARC-Authentication-Results: i=2; smtp1.osuosl.org; 
	dmarc=pass header.from=gmx.de;
	dkim=pass header.d=gmx.de header.i=fiona.klute@gmx.de header.a=rsa-sha256 header.s=s31663417 header.b="qg/1wj+6";
	arc=pass header.oldest-pass=0 smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1792417064;
	bh=wk0tQaP2JtH06WzzQ0gqY6NGaxueAE1zaoKxKiZGQvI=;
	h=Date:Subject:To:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=qNhgI/gNoYz//i/FTM+Ol4kgjydAUiWcfLUeLzHpJVyGmQdHWWsna0AWdfBGWrkEG
	 5MOP+6oUifWLwji7js+ic2oemC0DRDde/jrwSPvlh2+EtbZ5pY1tUVN2JVwg0Em2Mt
	 nl+U4SbFM0Rx0AmG7Ia06226wmNeisFutWBCn3lmsmPadIiuF5aoKrXZEYT5tqjiwr
	 GJn+0OlZ28fqHq7CgW6yzyCPTxoA7dwSXz2/+kQFRsVNQEInsM0Gj7gC6k6Rf3zLtt
	 2LXpwgF1r+CBaKpgo0v238SHRmc81LOCmAc5VW45F7WBW9P4U31YbNeVFSlRnkKtYh
	 WfrFh8WjoqD8g==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 30F2680F9E;
	Mon, 19 Oct 2026 13:37:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists1.osuosl.org (Postfix) with ESMTP id C2D151DE
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:37:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A8B1080F9E
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:37:42 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id CLc8vT3Og4un for <u-boot@lists.u-boot-project.org>;
 Mon, 19 Oct 2026 13:37:42 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 3ED6E80CD8
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=212.227.15.15
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1792417061;
 b=Y6l+QBExplGxrGJc3v7++PWSO5ByrtJB2mODP6NfZZbiKivHZc5QCR9iXdEBCZuIkaF1
 3KLb7XllPqYJAJe+ly0OhCFQMr8zxQv3uG2Nfml7BCDydQzJ9b1rtCO9S5Hy0lML4j3sx
 ruvYgtNfde9uKiQcsAVD2ltoSG3eh5KOZG9x/nzTnTNBjZbdFo1ve2/WqgkN+UBG4ckNM
 w9IL9Hp473BII4vNIEcCb61x/h8QS6r324QTNOB8E5uBGoARcHYxiKwPbGB7MgKrFC++0
 hvmUdopEbx75q8fG8q4x/CBtxfeiKLblpVKp2BbhpbW9iD7Fg+f2Fk2IzUArH2kf7sw==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
 c=relaxed/relaxed; t=1792417061;
 h=Received-SPF:DKIM-Signature:X-UI-Sender-Class:Received:Message-ID:
 Date:MIME-Version:User-Agent:Subject:To:References:Content-Language:
 From:Autocrypt:In-Reply-To:Content-Type:Content-Transfer-Encoding:
 X-Provags-ID:X-Spam-Flag:UI-OutboundReport;
 bh=wk0tQaP2JtH06WzzQ0gqY6NGaxueAE1zaoKxKiZGQvI=;
 b=K7TXncL2+aOJPN8conXro2EBYjuZZ3NtPDEgkoJad58Z9scJiwg4/rFc2qwybU5wXyv5
 /ZbtUU4rr5fWIgjwxuhOzTDMyekiYpp2SP4dQGgFuO4Lnu6nL6AZFDy+BugtvtH4l0rwy
 pNEGebni1uR+Fwy0MjBfvK13wgmilllF7z63HUBjZwj4qfJnyhaCth/YXkyLFPQxdbYWG
 REaCludCh6SEnsT//zsyHiM4tvvkpHg8pEyISnOr4izPqsT9EZgOV5Nt3kkzE6yxUW+IQ
 GcawPTxvAUnqBYISTXfoiwUr4i2UAl+t7fsoHikq8jj0xH4pZqP3SwTmRYFFSEeec0w==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
 dmarc=pass header.from=gmx.de;
 dkim=pass header.d=gmx.de header.i=fiona.klute@gmx.de header.a=rsa-sha256
 header.s=s31663417 header.b="qg/1wj+6"; 
 arc=none smtp.remote-ip=212.227.15.15
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=212.227.15.15;
 helo=mout.gmx.net; envelope-from=fiona.klute@gmx.de; receiver=<UNKNOWN> 
Authentication-Results: smtp1.osuosl.org;
 dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmx.de header.i=fiona.klute@gmx.de
 header.a=rsa-sha256 header.s=s31663417 header.b=qg/1wj+6
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 3ED6E80CD8
 for <u-boot@lists.u-boot-project.org>; Mon, 19 Oct 2026 13:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1792417059; x=1793021859; i=fiona.klute@gmx.de;
 bh=wk0tQaP2JtH06WzzQ0gqY6NGaxueAE1zaoKxKiZGQvI=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=qg/1wj+6sJ9DpFV9ih6XzYGs5c9AaKZ5lnHnWmriEHFxgls05NeXtVByom62OAY6
 TjLZINap/MqrOjXKX0A/oZ+7MwuWIiS9dZshP81O0i4hW16Vb6p2tlJSzairFAmZU
 Aw+mLXmJUrG/Vwra0Gn0Y+HGFh5A/VKUu3JuHdaxCd53n11mKOhNOtHSAxemduLPN
 DzTehLbW9s0oS5eIM1xsn0nJK19MBvL0vZTNouR2KtkYkXm+DJTh8nEoIrd+0eJiw
 ydgCsdjNhPBLm/AkEhFLJgrz/LWRiJUA4+vsmxXqod4/gEB5mR1WLUPn54DnJDguv
 faG2lMz2dkvO8PJCOQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MaJ7v-1x4r4R3mNx-00NaJq; Mon, 19
 Oct 2026 15:37:39 +0200
Message-ID: <0fea15c6-edd3-4f55-a347-d799aa86ad4d@gmx.de>
Date: Mon, 19 Oct 2026 15:37:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Security: "Permit write access only to listed variables"
 restricts only environment loading
To: Marek Vasut <marex@nabladev.com>, u-boot@lists.u-boot-project.org,
 Tom Rini <trini@konsulko.com>
References: <f23265e6-5dff-414e-94ec-ab7312a0e1dd@gmx.de>
 <542b5753-9c28-4565-b03f-f7b300351821@nabladev.com>
Content-Language: en-US, de-DE-1901, de-DE
From: Fiona Klute <fiona.klute@gmx.de>
Autocrypt: addr=fiona.klute@gmx.de; keydata=
 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
In-Reply-To: <542b5753-9c28-4565-b03f-f7b300351821@nabladev.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:E063ScKnHd6dTFL65R9vmirfkxf5TpHrx3z1pzcP2SrI+DD3VGE
 EM00FjBsMgDr1xU8QKbkdcWAunYmF3zjGU9FKsCSlZzR6zEIXUNpACLIlqj4kBOSw3brRfg
 V4ILEKnRjBB0uxXxTz2NbggPmuXUDrlbYpOaM16vmCdzzBricSgTQLqjATZJ4ax32mGHe5r
 2d5NwB7NSiiQiSSL4O7SA==
UI-OutboundReport: notjunk:1;M01:P0:369bd9Cn8uY=;rTIL0hx6yAlWpjODGV9OdN+UGrp
 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
 92M3a2vWNqJaLmCCRTqQ4NHbTVuMg=
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

Am 19.10.26 um 14:47 schrieb Marek Vasut:
> On 10/19/26 1:28 PM, Fiona Klute wrote:
>=20
> Hello Fiona,
>=20
>> The kconfig description of CONFIG_ENV_WRITEABLE_LIST says:
>>
>>> If defined, only environment variables which explicitly set the 'w'
>>> writeable flag can be written and modified at runtime. No variables
>>> can be otherwise created, written or imported into the environment.
>>
>> This does not match actual behavior, "env set" and "env import" can=20
>> modify variables as usual.
>=20
> Right, and if the attacker has access to these commands, that means the=
=20
> attacker has shell access to U-Boot, at which point they can do pretty=
=20
> much anything with the system. If the attacker has shell access to U-=20
> Boot, it is game over. For CONFIG_ENV_WRITEABLE_LIST to be usable, the=
=20
> U-Boot shell access must be blocked (bootdelay set to -2).
>=20
>> The only thing that is blocked is loading variables without the=20
>> "writable" flag from stored environment on boot (and "env load" based=
=20
>> on what I see in the code, but I didn't test it).
>>
>> As far as I can see, the issue has existed since the option was added=
=20
>> in commit d045cbacf2529266bb312add023e12c0d400bf67 ("env: Add support=
=20
>> for explicit write access list"), where the commit message explicitly=
=20
>> states
>> "env import" and "env set" would be blocked.
>>
>> I consider this a security issue because preventing modifications that=
=20
>> would circumvent security measures seems to be the whole point of=20
>> CONFIG_ENV_WRITEABLE_LIST, and it only does a small part of what it's=
=20
>> documented as doing. For my current setup restricting what can be=20
>> changed in stored environment is enough, so I don't have a strong=20
>> opinion on whether description or code need to be fixed.
> Please see above, does the security concern persist if U-Boot shell=20
> access is not available ?

As I wrote, for my setup the loading restriction is sufficient,=20
precisely because I'd block shell access in production.

But that doesn't change that the fact that the description promises=20
security restrictions that don't exist, and if someone relies on those=20
without checking they'll likely get into trouble. That why I consider=20
this a security issue.

And for someone who does check (like I did) it's rather concerning if a=20
write access the documentation says will be blocked actually works, and=20
it wastes time figuring out what's actually going on, even if the end=20
result is "what I really need works, the documentation is wrong".

It's fair to say there's no point in having environment restrictions if=20
someone has shell access, but having documentation describing such=20
restrictions suggests otherwise (U-Boot does a lot of things, I don't=20
know everything other people might get up to!). Again, I think fixing=20
the documentation would be an appropriate way to handle this, but that's=
=20
not my call.

