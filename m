Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F1CCC282C1
	for <u-boot@archiver.kernel.org>; Fri, 28 Feb 2025 15:43:23 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 0D7A4809D4;
	Fri, 28 Feb 2025 16:43:22 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1740757402;
	bh=kK3kO4tQueXhKNVC6YcDRhoIXOOxPAmyg82qiLODFNU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:List-Id:
	 List-Unsubscribe:List-Archive:List-Post:List-Help:List-Subscribe:
	 From;
	b=PVdzBF/+h35iIlU+ZW9l15q5iPNmtXN/TWjKpShfXgmvwNuHXb8v7q6hGKoYsPDvd
	 3ZWiyuYHjFQlFpoI3gAU2BnjNkZiuyZrjrEkVLAz/WiMReHjAziczGhXNj9K1YJ8c9
	 IKcQno/iMfIqO6o1aqh3Mh2aAiLTCdrH+SNILJz06Lu2Dor465EUiEG/kSyCO3v6mR
	 Fc+a4Yotwz22b36IqLNAPTkRgKUq1yTKPv8jeV+QhHuWEBbobVao7A9OFKdXglQHq7
	 7EIMpvyWSpST53UEJXLZmnyBn2OdBmG4AyLf7LFFi66I8lYuc1hvJPlRqWhxplU/uS
	 aOeQDces10yNw==
Received: by phobos.denx.de (Postfix, from userid 109)
 id 8EC2F810F4; Fri, 28 Feb 2025 16:43:19 +0100 (CET)
Received: from mout-u-204.mailbox.org (mout-u-204.mailbox.org
 [IPv6:2001:67c:2050:101:465::204])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 79D29807D7
 for <u-boot@lists.denx.de>; Fri, 28 Feb 2025 16:43:17 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=denx.de
Authentication-Results: phobos.denx.de; spf=fail smtp.mailfrom=sr@denx.de
Received: from smtp202.mailbox.org (smtp202.mailbox.org [10.196.197.202])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by mout-u-204.mailbox.org (Postfix) with ESMTPS id 4Z4CCl121dz9tq0;
 Fri, 28 Feb 2025 16:43:15 +0100 (CET)
Message-ID: <a056bb57-ece6-49d0-9480-bc590b34991a@denx.de>
Date: Fri, 28 Feb 2025 16:43:13 +0100
MIME-Version: 1.0
Subject: Re: [PATCH v2 07/14] cyclic: invoke uthread_schedule() from schedule()
To: Jerome Forissier <jerome.forissier@linaro.org>, u-boot@lists.denx.de
Cc: Ilias Apalodimas <ilias.apalodimas@linaro.org>,
 Tom Rini <trini@konsulko.com>, Rasmus Villemoes <ravi@prevas.dk>,
 Simon Glass <sjg@chromium.org>, Patrice Chotard <patrice.chotard@foss.st.com>
References: <cover.1740499185.git.jerome.forissier@linaro.org>
 <f209e0a9ca2dc8687599d9938fc319779cd8e08d.1740499185.git.jerome.forissier@linaro.org>
 <25a26671-78aa-4d24-8457-aaa7008addf1@denx.de>
 <1d2680d2-aa0f-4dbd-b446-5c061cbbac36@linaro.org>
Content-Language: en-US
From: Stefan Roese <sr@denx.de>
In-Reply-To: <1d2680d2-aa0f-4dbd-b446-5c061cbbac36@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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
Errors-To: u-boot-bounces@lists.denx.de
Sender: "U-Boot" <u-boot-bounces@lists.denx.de>
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

Hi Jerome,

On 27.02.25 18:05, Jerome Forissier wrote:
> Hi Stefan,
> 
> On 2/27/25 13:30, Stefan Roese wrote:
>> Hi Jerome,
>>
>> On 25.02.25 17:34, Jerome Forissier wrote:
>>> Make the schedule() call from the CYCLIC framework a uthread scheduling
>>> point too. This makes sense since schedule() is called from a lot of
>>> places where uthread_schedule() needs to be called.
>>>
>>> Signed-off-by: Jerome Forissier <jerome.forissier@linaro.org>
>>
>> Frankly, at first I was wondering a bit, if and why another framework
>> for "multitasking" is needed in U-Boot, additionally to the cyclic
>> framework that I introduced a few years ago. Which was greatly enhanced
>> by Rasmus over the time. But looking at your "uthread" implementation
>> it makes sense to add such a probably more intuitive interface as well.
> 
> cyclic is clean and simple and certainly well suited when introducing new
> code. But when reworking older code I find it somewhat difficult to use
> due to the need to keep a context and pass it everywhere. This can lead
> to lots of changes when call stacks are deep.
> 
>> In general I'm really happy seeing activity in this "multitaking" area
>> in U-Boot. As it brings a lot of new possibilities and, as you've also
>> shown in your patchset, may greatly help reducing boot time in the
>> USB example. :)
> 
> Thank you.
>   
>> One question though:
>> Do you have some means in your uthread framework, measuring and
>> perhaps limiting the time spent in these uthreads? If and how is a
>> preemption of a uthread possible? So that it does not consume too
>> much time resulting in e.g. things like dropping input chars on
>> the prompt? Sorry, I did not thoroughly go through all your code
>> to get the internals from there. It would be great if you could
>> elaborate a bit on this.
> 
> That's a very valid point. The short answer is no, there is no control
> over how long a thread keeps the CPU busy. uthread is similar to cyclic
> in that respect. That said, I occasionally noted the issue you mentioned
> about the console dropping characters, and yes it is annoying. I believe
> there is a simple solution though. If we can somehow make sure we're
> always scheduling the main thread every other time, we're much less
> likely to starve it from the CPU, especially when many threads are
> active. That is, assume we have 2 threads in addition to the main thread.
> The thread list is main -> thread1 -> thread2 and uthread_schedule() will
> iterate in that order. So back to main only after thread1 *and* thread2
> have run and called uthread_schedule(). The idea is to schedule in a
> different order: main -> thread1 -> main -> thread2 -> main etc.,
> effectively giving a higher priority to the main thread (which would be
> the console parsing thread).

Sounds like a good idea / improvement to me.

Thanks,
Stefan

> I feel that introducing preemption would be opening a can of worms...
> Because in this case we would likely need locking everywhere. Without
> preemption, we still do need locking in theory, it's just that I have
> not yet identified critical sections where locks would be mandatory in
> the code that I have "parallelized". BTW I believe a uthread lock would
> be trivial to implement like so:
> 
> struct uthread_lock {
> 	bool locked;
> };
> 
> void uthread_lock(struct uthread_lock *l)
> {
> 	while (l->locked)
> 		uthread_schedule();
> 	l->locked = true;
> }
> void uthread_unlock(struct uthread_lock *l)
> {
> 	l->locked = false;
> }
> 
>>
>> For this patch:
>>
>> Reviewed-by: Stefan Roese <sr@denx.de>
>>
>> Thanks,
>> Stefan
> 
> Thanks,

