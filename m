Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DCA7606A331
	for <u-boot@archiver.kernel.org>; Tue, 17 Nov 2026 19:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.u-boot-project.org header.i=@lists.u-boot-project.org header.a=rsa-sha256 header.s=default header.b=apL4o13o;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wmNqitWC
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 85E1580F70;
	Tue, 17 Nov 2026 19:31:16 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id LIzzcVFgBCG2; Tue, 17 Nov 2026 19:31:15 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp1.osuosl.org 9F0C18116A
Authentication-Results: smtp1.osuosl.org; arc=none smtp.remote-ip=140.211.166.142
ARC-Seal: i=1; d=osuosl.org; s=arc; a=rsa-sha256; cv=none; t=1794943875;
	b=Cp48UwCRpT+QtMrIgjEpekS58kERpVYIxS1Z7HZnDdV+ZZjrqQragWA/ov5oqGD+PDxz
	 +/E5isWfE50t2oOvxquMNkxmVybRDjrEjpUUkttkkaJvIq1L+YCDD45YOcZiX4SKgQEh7
	 va/G4qvibRAkT/ojWsko4iTn/5zRu+tVnyz21jkqSOORtdFhtDxHv3rddVOCyIA+sEmLW
	 PzCoelm4LY9WTKdmKkP06hNv13dgCNlgFa3+DKdcpCx1f/nLX/LfpJu49uv59jUwccvLi
	 qtC81VdiTMTRbXzTvalxoe3xa8KWyN9zBKvom8TTFr0QGyfXcDhHKMAx8BmPcZAWCkg==
ARC-Message-Signature: i=1; d=osuosl.org; s=arc; a=rsa-sha256;
	c=relaxed/relaxed; t=1794943875;
	h=X-Comment:DKIM-Signature:X-Original-To:Delivered-To:Received:
	 Received:X-Virus-Scanned:X-Spam-Flag:X-Spam-Score:X-Spam-Level:
	 X-Spam-Status:Received:ARC-Filter:Received-SPF:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:Content-Type:Content-Disposition:In-Reply-To:X-BeenThere:
	 X-Mailman-Version:Precedence:List-Id:List-Unsubscribe:List-Archive:
	 List-Post:List-Help:List-Subscribe:Errors-To;
	bh=VHFgUCLPR7qOaE67cYVk4IhBfAc5uO7QV5TMzD76uyE=;
	b=aAo4sAqPmtcpmEKmwSVuxfd3DYJLJ1RlXqOx6/tje9finLKTUZYICp4EUbWMDkQM6P7h
	 y2ZrKQBgx9rollFu7GB4FwYpmwF94s+QxAkUy2VP7k+cqqOguQiwe3795Gahppa1/jTC3
	 Quxz2C+hTg+jtRDd2PmS/LfBPylnfhMxfmg2a2J4407xlxUVB9kjcwLD7AdR94j77hId0
	 MywexXeUxHKADJcrV+dNCxkkwh+plaW1B1mp2hF0HnOMrWXduN3HRsl9l+GxFYJ6c6rtO
	 imgXqQlqNghyhVKDJsLZtSwNO6/zxVNp48VgsCkVkD0oxGqQ0rYGU4MQ0BhPZgeelfg==
ARC-Authentication-Results: i=1; smtp1.osuosl.org; 
	arc=none smtp.remote-ip=140.211.166.142
X-Comment: SPF check N/A for local connections - client-ip=140.211.166.142; helo=lists1.osuosl.org; envelope-from=u-boot-bounces@lists.u-boot-project.org; receiver=<UNKNOWN> 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=lists.u-boot-project.org; s=default; t=1794943875;
	bh=VHFgUCLPR7qOaE67cYVk4IhBfAc5uO7QV5TMzD76uyE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=apL4o13osCALe/em8FWzzpqqXBixXXh5VY9ZzOFH/LOhD7ywFyKrhnylABb73qzKl
	 UaOY1D1svCq7WCHjZzH20KKd84qgaJz7pqsA/Zd0JnRNSjeXGXbGovdk6JEAOjuyKj
	 Ji4MZSMgg2JF4yh75OVM0g+sFB8lu03s8Fr9l+YrN1ePdBmXp1/IklXKpuXDKR79yt
	 9i6fRdcgQ9HCGGGow4Bw9esvvcK/XUItqOtqkCBihUQUjjovBTl9L92fpwNvxVWl9p
	 /nA9GW3q2wCi2Pv8WJhwmniSMnzTSRiuTnr9/Ug6IGc4DkUYZggNIfbCACzTP7lHRt
	 lNYS5ubZd0WIQ==
Received: from lists1.osuosl.org (lists1.osuosl.org [140.211.166.142])
	by smtp1.osuosl.org (Postfix) with ESMTP id 9F0C18116A;
	Tue, 17 Nov 2026 19:31:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists1.osuosl.org (Postfix) with ESMTP id 8B18F49B
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 19:31:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6FE2860729
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 19:31:14 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id KHZNLVoDxXep for <u-boot@lists.u-boot-project.org>;
 Tue, 17 Nov 2026 19:31:13 +0000 (UTC)
ARC-Filter: OpenARC Filter v1.3.2 smtp3.osuosl.org 5F893605F7
Authentication-Results: smtp3.osuosl.org;
 arc=none smtp.remote-ip="2607:f8b0:4864:20::72e"
Received-SPF: Pass (mailfrom) identity=mailfrom;
 client-ip=2607:f8b0:4864:20::72e; helo=mail-qk1-x72e.google.com;
 envelope-from=ralph.siemsen@linaro.org; receiver=<UNKNOWN> 
Authentication-Results: smtp3.osuosl.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp3.osuosl.org; dkim=pass (2048-bit key,
 unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256
 header.s=google header.b=wmNqitWC
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com
 [IPv6:2607:f8b0:4864:20::72e])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5F893605F7
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 19:31:12 +0000 (UTC)
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-93f22a8515eso21294885a.2
 for <u-boot@lists.u-boot-project.org>; Tue, 17 Nov 2026 11:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794943871; x=1795548671;
 darn=lists.u-boot-project.org; 
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=VHFgUCLPR7qOaE67cYVk4IhBfAc5uO7QV5TMzD76uyE=;
 b=wmNqitWCdn5bPnoMDRgsb4n9O7jmmj+XJg7KyMjhp6I3RSj5hSVLfNG/F7E0ObatUa
 KMqmurq+mdzNKBzz5yv9+eoeLJVrJUeBKX5tWFDvQHe6vQc1Uw2iKBXCjai1OBLDLvyd
 qGzusMmVtxkfLJc/f8eBr+62mhoQvONHr8ivc+XRfaDvpNUx5qyPwtOc7bD/m+0AVRqY
 3DB6yw8gOVgKDVvuRmUn9tn/uhlQVpL/fwNJUnToQnbOiEL1XW7uvKJ+AkuTSs1Q9z5N
 jENlFqbW7noSv/FgkBMfmpykfwzYNqBq8EKIySHzUN02crEwkvHtHc0eKDKfeHooz3fp
 w2LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794943871; x=1795548671;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=VHFgUCLPR7qOaE67cYVk4IhBfAc5uO7QV5TMzD76uyE=;
 b=KoT1X4ak1DPy6EjcFLrBZFynIAJvoebA/GMVgJ98ZRygFToa0LirjiKnwBN42xPj9V
 YNL0q2YM+u8cyZ5NqzcYXEXIhUn33Ku99YUgR3mKRLY0eUcy2UHzcR+y0GvWGS8z1pS3
 LFlxUM3Rnk5Eig82b8UBcjnnKt5ElQ1EwdJWL3XjAPl551qtnURAEuIETQxfo9/Btz8m
 lSPlBgAaW8tWaEu0Sj2HP1UvWar9RO7UFSAme68Pa03BBRxzYXvIP8A9GL+hDk+RIVjt
 uHKZCnnSCGPNL69k9GSOOdrX6fgpdKjgiFzgOqjrc+0KRBQZoc6F1p+5JB1e1UQmzqEA
 tJ2Q==
X-Gm-Message-State: APuU4Z+oGkbudSu1WnUxpFU7X5GJqLJcWNM1xFRbMjlKod7dUmSZ1+Tm
 74jXliKWQpu0lJnUMRqj7LCrPjDBSwyl8FkOUR+4vL5wdPmGjdhIDt/MK0tfqJE4030=
X-Gm-Gg: AYBFou1v5d8LNAoK8RrekMQmjgYHjLzoWlStTV0tF4Xg7zvd89YW8A24jReEQ+puv5t
 kAHY/obQZZnw4mczyHjOL9yY7X9GHpwY7VmYLsjKfeXJlAYdicwcS1UcfVoz/uw8oQru15sdn30
 q4B/m+WIENIJ5G8CW11tgd5njen37pVimatZZ7EdSczaJW79Gd1gst8bLLWt78unJYIaqzvdgFB
 HQ67U5moFkAuGPq6pc+UQ45WJfHHJnHBDzIvOWQXmciKrcIpaiSfo+8OBl+GBdWPEBPTCekwjnn
 rx4cHdsRQq1yqG5Jv3f+IiGKHrRqLAzEHh7kdd6iq0NzTi04xbXcnCtIkg+7WXSeJOsH3sd290a
 SPbuIm0wNX6947EYWS9y+6QCPdB9wHbBgkNrzq5XKpWVUfj+OCMycN+2jdxWyViDDmVSPnjyOhK
 WT/dQgqQjkAzD3i4LZftwMoVc/OcNeY87NHym3q1Dz/pubDkINTIrw2v6VoXtruO5bxOJyNedJP
 6Bmdu5K4o/NK8qmcIDIeaMCnDuXRw8/hufrFwWgG0Ui+/MniYsWABADOO7TPxrI8CEzziL3hDcQ
 nUzoUm42s31mc/0r8ezdmnfaO3d/ZqTxJdZRlOR4h+6LFqm9Hl4qoCCYyWdPABPtEtcLw7W7P7w
 Y4AQZ7rYrPR8vWau6cR8LJfVHN1Mv1f3ho0csaeKO8JLcLcw=
X-Received: by 2002:a05:620a:2907:b0:949:5ee9:ab27 with SMTP id
 af79cd13be357-9499965e07amr111675685a.83.1794943871193; 
 Tue, 17 Nov 2026 11:31:11 -0800 (PST)
Received: from localhost ([204.244.107.52]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9499b75aa1csm2022385a.20.2026.11.17.11.31.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Nov 2026 11:31:10 -0800 (PST)
Date: Tue, 17 Nov 2026 14:31:10 -0500
From: Ralph Siemsen <ralph.siemsen@linaro.org>
To: E Shattow <e@freeshell.de>
Cc: u-boot@lists.u-boot-project.org, Tom Rini <trini@konsulko.com>,
 Quentin Schulz <quentin.schulz@cherry.de>,
 Neil Armstrong <neil.armstrong@linaro.org>
Subject: Re: [PATCH v4 1/2] doc: develop/sending_patches: add tips for series
Message-ID: <avyrfjvcAVBe4qQ5@maple.netwinder.org>
References: <20261112-doc-sending-patches-v4-0-d6f4b7e3eeba@linaro.org>
 <20261112-doc-sending-patches-v4-1-d6f4b7e3eeba@linaro.org>
 <33c70db1-226a-4108-b690-ad07cecf7752@freeshell.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <33c70db1-226a-4108-b690-ad07cecf7752@freeshell.de>
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
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Nov 12, 2026 at 03:19:18PM -0800, E Shattow wrote:
>On 11/12/26 13:55, Ralph Siemsen wrote:
>> +
>> +A series of related patches can be sent as a "patch series", as described
>> +above. Individual patches should be small and self-contained. Likewise,
>> +this also applies to each "patch series". Keep the following in mind:
>> +
>> +* large series are harder to review. Maintainers are busy and may postpone
>
>This reads a bit awkwardly. Maybe "A large series is harder to review"
>or "large series patches are harder to review", depending on what the
>meaning is you are wanting to convey.

I'll see if I can reword it more clearly. I was referring to series with 
a large number of patches. The existing document already talks about 
(individual) large patches.

>Either seems to me like injecting your opinion about what is easy or
>difficult to review which does not align with my view of this that the
>difficulty in reviewing a patch series is proportional to the discipline
>in focus the author has for presenting their idea and developing it to a
>meaningful change with the assistance of code review; 

Knowing how to present ideas clearly and develop them based on review 
feedback is something that must be learned. Some people are naturally 
good at it, but the rest of us appreciate all the guidance we can get.

>if it will
>require a great deal of involvement then don't expect to just dump your
>code off on the list and have it be merged because you gave this "gift"
>of 100+ small patches in a series, or even a single patch large-or-small
>that is several disjointed ideas or bug fixes.

How can we help an author to recognize that their code is going to 
require a great deal of involvement from the reviewer? Most submissions 
are made in good faith, with lots of effort on the author's part. The 
author cannot read the reviewer's mind, so we have to try to document 
expectations as best we can. That was my goal with this change.

>Nothing happens "quickly". The point of bug fixes being independent is
>so they can be reviewed and verified independently from unrelated
>changes. Quickness is not the driver of getting merged or not merged, or
>it should not be.

I'll reword it without "quickly". But I do think that certain bug fixes 
are more urgent, and should be handled "quickly". Such fixes should not 
be bundled into a series with other changes. Which seems pretty obvious, 
but still worth writing down.

>> +* tools like ``b4`` and ``patman`` send the entire patch series to
>
>Do correct me if I am mistaken: for consistency I think we are
>recommending people use b4 and patman, and not tools similar to these.

Indeed those two are recommended earlier in the document. I'll remove 
the ambiguous "like" and just write "The b4 and patman tools ..."

>> +  reviewers, even though individual reviews may only care about some 
>> parts.
>> +  Filtering out the relevant parts takes time away from actual reviews.
>> +
>What is an "actual review" ? That sounds so strange.

I meant "actually doing code review", as opposed time spent filtering 
out emails (parts of series) that are not of interest to the reviewer.

The tools collect reviewers for each patch in a series, but they send 
all patches to all reviewers. So if the series contains changes to 
driver A and B, each with their own maintainer, then both maintainers 
have to dig out the part they care about.

To avoid this, authors need to be aware of this when using the tools. 
One warning sign is a large list of auto-generated recipients, which 
usually indicates that change needs to be split up further.

>Drop my R-by tag, thanks. -E

Will do.

-R
