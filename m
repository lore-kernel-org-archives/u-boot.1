Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE6A606A31C
	for <u-boot@archiver.kernel.org>; Tue, 10 Nov 2026 17:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=pggoa86Z;
	dkim=fail reason="signature verification failed" (2048-bit key, unprotected) header.d=postmarketos.org header.i=@postmarketos.org header.a=rsa-sha256 header.s=key1 header.b=QU9zNlgV
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0232F409E3;
	Tue, 10 Nov 2026 17:59:27 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id XSXgl5jSxFN6; Tue, 10 Nov 2026 17:59:25 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp4.osuosl.org 839C6408D1
Authentication-Results: smtp4.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794333565;
	b=TcZo7xe7jTTBH8J2cOuc1LRFo8lrOtsR1dXsucVgWUyn/bUz8+ZHRnngplusXcbNk0+M
	 JzXDlXCgriDjc6b7EQSdRIWci7JUV+YvjTmzNqJIduUWvZgEeZaTdKHfmSEq2mkljWnO9
	 pGI5Uet/crpSV3t7X0xB7jr2k3wllWxkYTJsuWV/pm3KTpBguU/QzZwoFRWMp1OMEjbFn
	 /T7Qur+u3m7kSfYE4cqUpgb/eR3ePg3l4mNjiWzY4nOyzoL6+sBPFqfXkJ6XV75Msr0A7
	 OVcYqjWRkAYpI0kqPf/0YbWWeahXCvPC4/PlCCkmvcgW+aW2muUvQNZFjEvqzDSTSoQ==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794333565;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:X-Greylist:Received-SPF:Received:
	 X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:X-Mizu-Trace-ID:
	 X-Migadu-Flow:MIME-Version:Date:Content-Type:
	 Content-Transfer-Encoding:From:Message-ID:TLS-Required:Subject:To:Cc:
	 X-BeenThere:X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:
	 List-Archive:List-Post:List-Help:List-Subscribe:Reply-To:Errors-To;
	bh=u4ZxPRieqZhZnUDLo4IygThfkJrKGiW/8r53xbrzUcI=;
	b=aIqaZxITspFQTNSBVZ/mJKe4SIzw6SJewGOstG2i1X/4oQLARP1x+Ony4+CVwyaCk9mB
	 X4aEd0HPloazG3JJVU0WpOTOrAzHlGy/TUgIB3TeHzdoJfu7rZP4GtRQ4WmCFmGywfTKc
	 +ZLnLA1kC2CWckFvd03//aI74+ybE+XwppqnQMJSvQAGsNSFS5tQptv74MHu7N55D5XtR
	 jLkQE7zZ+vBLNMlNH0ZAHz0VB0BHtynztrJB5fFh7adsGgkOK7A7xDSmQ9zvAQObuLMbV
	 Az9XVnDpDcr4zb3+vkR96g/gLG8obc8FEOQlvUb82573FkRBa9mre+yEA0XY9Ag6vkQ==
ARC-Authentication-Results: i=1; smtp4.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794333565;
	bh=u4ZxPRieqZhZnUDLo4IygThfkJrKGiW/8r53xbrzUcI=;
	h=Date:From:Subject:To:Cc:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Reply-To:From;
	b=pggoa86Z/UgTSWO3+uzMVKMldWhkui5CubyUnkKPstcI+pancelDvZu+j4TCcieyu
	 R6zo4EpRE8MakItsyFYsrMdmaTQz4eFJyQDHt5xE5URyqeJOs72YCjVM68InGiq1oD
	 PjcJKg2XfMRdrl3A8al0lLhMif4AH8wz3wpMzZwU9Zg9hO5J1EavCHNkw+X1zNHct+
	 4a8t2vVTIVqMPrSW5KyP8iQe880LJEX42gkoPcA5vlPzmz8xShakqcwUtJZNdTAVvd
	 cYulWHdJEVorbJwj2lJ/fiebt4jCEgC04FXEn33TFIr38Me3smBGwJ9ye+46gSQPcv
	 uswDmArkH7+5w==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp4.osuosl.org (Postfix) with ESMTP id 839C6408D1;
	Tue, 10 Nov 2026 17:59:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists1.osuosl.org (Postfix) with ESMTP id 5F76D28C
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 17:59:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 50ECB60A46
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 17:59:23 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u3VJQNga8B9m for <u-boot@lists.u-boot-project.org>;
 Tue, 10 Nov 2026 17:59:21 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 9ED1D60871
Authentication-Results: smtp3.osuosl.org; arc=none smtp.remote-ip=95.215.58.183
X-Greylist: delayed 63 seconds by postgrey-1.37 at util1.osuosl.org;
 Tue, 10 Nov 2026 17:59:20 UTC
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none)
 header.from=postmarketos.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=postmarketos.org header.i=@postmarketos.org
 header.a=rsa-sha256 header.s=key1 header.b=QU9zNlgV
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=95.215.58.183;
 helo=mta1.migadu.com; envelope-from=funderscore@postmarketos.org;
 receiver=<UNKNOWN> 
Received: from mta1.migadu.com (out-183.mta1.migadu.com [95.215.58.183])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9ED1D60871
 for <u-boot@lists.u-boot-project.org>; Tue, 10 Nov 2026 17:59:20 +0000 (UTC)
X-Envelope-To: u-boot@lists.u-boot-project.org
DKIM-Signature: a=rsa-sha256; bh=u4ZxPRieqZhZnUDLo4IygThfkJrKGiW/8r53xbrzUcI=; 
 c=simple/simple; d=postmarketos.org;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794333558; v=1; x=1794938358;
 b=QU9zNlgVD7hxiXBqo/un7i1e0jQwIsBqRgNPHQLMiABAUzsAPvm0Ja3l6JmN7sUqcnkVL9rU
 nog+wcYrxjrHkRPN6GGYqwSpHrVpkD9QzBVuVvteph590ECXgy8av/yOawTQx8z1MKIZjTHaEq5
 03za70tpQeRQAFhBxDK5Y3cEPLDeVXQz5T8gogyPauGe0inAgtC3NCFAhftGlNFH1xn0FSZLR8F
 NulOot0rlTGThchpx2VM1TtRzsqW3xnPxBBljcClMVQkFr87+aGkuYH/IpYBaeZcVXxsyfVyaDU
 M0ycKGClZIHxqwqL2RgREXexMjxfa5igzFXRhohoI18/Q==
X-Envelope-To: u-boot@lists.u-boot-project.org
Received: by smtp.migadu.com with ESMTPS id e09c713606dfae68;
 Tue, 10 Nov 2026 17:58:15 +0000
X-Mizu-Trace-ID: e09c713606dfae68
X-Migadu-Flow: FLOW_OUT
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Date: Tue, 10 Nov 2026 17:58:11 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
From: "Ferass El Hafidi" <funderscore@postmarketos.org>
Message-ID: <f483d695f11cae36032782e8eac49e59457135f3@postmarketos.org>
TLS-Required: No
Subject: Re: [RFH] Writing a project Code of Conduct
To: trini@konsulko.com
Cc: xypron.glpk@gmx.de, mkorpershoek@kernel.org,
 u-boot@lists.u-boot-project.org
X-BeenThere: u-boot@lists.u-boot-project.org
X-Mailman-Version: 2.1.30
Precedence: list
List-Id: U-Boot discussion <u-boot.lists.u-boot-project.org>
List-Archive: <http://lists.u-boot-project.org/pipermail/u-boot/>
List-Post: <mailto:u-boot@lists.u-boot-project.org>
List-Help: <mailto:u-boot-request@lists.u-boot-project.org?subject=help>
List-Subscribe: <https://lists.u-boot-project.org/mailman/listinfo/u-boot>,
 <mailto:u-boot-request@lists.u-boot-project.org?subject=subscribe>
Reply-To: b415d946-eda6-4ac8-a8ec-4b00a379effb@gmx.de
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS autolearn=no autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi,

On Tue, 10 Nov 2026 16:12:08 +0100, Heinrich Schuchardt wrote:
>On 11/10/26 11:32, Mattijs Korpershoek wrote:
>> Hi Tom,
>>=20
>>=20On Tue, Nov 03, 2026 at 11:20, Tom Rini <trini@konsulko.com> wrote:
>>=20
>>>=20Hey all,
>>>
>>> Getting back on track with project administrative tasks, one thing I
>>> have talked about the project needing for some time is a code of
>>> conduct. In my mind, the best starting point here is, are there code =
of
>>> conducts in other projects that people use and they feel would be a g=
ood
>>> example for us to adopt? Thanks!
>>=20
>>=20Have you considered the Contributor Covenant Code of Conduct?
>> That's the one Linux uses, see:
>> https://docs.kernel.org/process/code-of-conduct.html
>>=20
>>>
>>>=20--=20
>>>=20Tom
>
>https://policies.python.org/python.org/code-of-conduct/
>is another reasonable code of conduct.
>
>Best regards
>
>Heinrich

Yes I think either the Contributor Covenant or the Python Code of Conduct
should do here. What is good about both of them is that they both give ex=
amples
of appropriate and inappropriate behavior, while not being exhaustive and
leaving a bit of room for the people responsible to enforce it...

...speaking of that:
Having a CoC is definitely a step in the right direction and I applaud th=
e
effort towards making that happen. However, I think what should also be t=
alked
about at the same time is its enforcement. Of course, it is easy to just =
"slap"
a code of conduct to the project, but actually enforcing it, that is easi=
er said
than done.

Ideally there should be a "CoC team" that would have the responsibility
of dealing with conflicts between community members. That team does not
necessarily have to be comprised of people from the PLC (although having =
at
least 1 or 2 people with access to infrastructure would be helpful, shoul=
d
there be a need to, for example, block an individual).

It also does not have to be very big (honestly depends on the size of the=
 whole
community and how many CoC cases come up, but 3-5 people is already a goo=
d start)
I highly recommend seeking CoC training for these team members in order t=
o be
better prepared to handle cases. It's not usually free, but it is worth i=
t IMO.
I also think it would be preferred to have people from diverse cultural b=
ackgrounds
in that team.
These people would have their contact info public, so people can privatel=
y
contact them in case of issues. (and I've seen in many communities that t=
hey
have a coc@ email alias that goes to all CoC members, that is also a good=
 thing
to have, but people should also be able to contact a member privately)

Also another thing that is actually mentioned in both CoCs (kernel/Python=
) is
confidentiality. This forms some kind of trust between reporters and the =
team,
so they know they won't be exposed (and in turn potentially harassed). So=
rry if
that one seems obvious, but I think it's quite important to highlight tha=
t.
Of course, in the interest of being somewhat transparent, the team can pu=
blish
so-called "transparency reports" where the team can talk about each indiv=
idual
case while not going into too much detail to preserve reporter anonymity
(see [1] for an example - disclaimer: I am a Nura/pmOS team member).

Finally, the space in which the code of conduct applies should be made cl=
ear.
That is mentioned in the PSF CoC ("Scope" [2]), I think this question is =
not all that
hard to answer. I would guess: (1) u-boot-project ML, (2) #u-boot IRC cha=
nnel,
(3) u-boot custodian spaces? I don't feel strongly about that, you should=
 define
it however it makes sense. But it really helps so people know where the C=
oC
applies and where it doesn't. Of course, it doesn't prevent the team from
acting on seriously inappropriate behavior outside the community from a
community member.

So these are my thoughts on the whole thing. It does take quite a bit of
organisation and work. It is worth it? IMO absolutely :)

Thanks for reading through all this!

[1]: https://docs.nura.eco/policies-and-processes/community/code-of-condu=
ct/transparency-reports.html
[2]: https://policies.python.org/python.org/code-of-conduct/#scope

Best regards,
Ferass
