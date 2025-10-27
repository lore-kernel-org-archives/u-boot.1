Return-Path: <u-boot-bounces@lists.denx.de>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30ADACCF9EB
	for <u-boot@archiver.kernel.org>; Mon, 27 Oct 2025 06:56:12 +0000 (UTC)
Received: from h2850616.stratoserver.net (localhost [IPv6:::1])
	by phobos.denx.de (Postfix) with ESMTP id 419C582A9E;
	Mon, 27 Oct 2025 07:56:11 +0100 (CET)
Authentication-Results: phobos.denx.de; dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=u-boot-bounces@lists.denx.de
Received: by phobos.denx.de (Postfix, from userid 109)
 id 7113582C7F; Mon, 27 Oct 2025 07:56:09 +0100 (CET)
Received: from freeshell.de (freeshell.de [116.202.128.144])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by phobos.denx.de (Postfix) with ESMTPS id 3981F80422
 for <u-boot@lists.denx.de>; Mon, 27 Oct 2025 07:56:07 +0100 (CET)
Authentication-Results: phobos.denx.de;
 dmarc=fail (p=none dis=none) header.from=freeshell.de
Authentication-Results: phobos.denx.de; spf=pass smtp.mailfrom=e@freeshell.de
Received: from [192.168.2.54] (unknown [98.97.26.255])
 (Authenticated sender: e)
 by freeshell.de (Postfix) with ESMTPSA id 0771AB22014B;
 Mon, 27 Oct 2025 07:56:05 +0100 (CET)
Message-ID: <faf31d40-656c-4eee-b564-80586860cd75@freeshell.de>
Date: Sun, 26 Oct 2025 23:56:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1] tools: update-subtree.sh improve user experience
To: Quentin Schulz <quentin.schulz@cherry.de>, Tom Rini <trini@konsulko.com>
Cc: u-boot@lists.denx.de
References: <20251015083842.46057-1-e@freeshell.de>
 <14b0f59c-adec-4ccd-9854-09bbf335bdc8@cherry.de>
Content-Language: en-US
From: E Shattow <e@freeshell.de>
In-Reply-To: <14b0f59c-adec-4ccd-9854-09bbf335bdc8@cherry.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Hi Quentin, thanks for the review.

On 10/20/25 09:01, Quentin Schulz wrote:
> Hi E,
> 
> On 10/15/25 10:38 AM, E Shattow wrote:
>> Makeover of the script:
>> - Usage now explains at each step what is expected from the user.
>> - Default branch name is no longer hard-coded and is queried when
>> omitted.
>> - Additional operations 'update' and 'log' close the logic gap between
>>    expecting the user to provide a commit id and where from this
>> commit id
>>    should be obtained.
>> - Use 'set -x' context to show git invocation where appropriate
>> - Sort options for usage output
>> - 'pick' operation detects merge commit id and displays suggested commits
>>
>> Additionally the LwIP remote is now using the Savannah mirror system:
>>
>> https://lists.gnu.org/archive/html/savannah-users/2025-05/msg00002.html
>>
> 
> Please try to split changes into multiple commits. There's a lot of
> unnecessary noise and it makes difficult to review your patch otherwise.

Yes this is incomprehensible as a diff. It should be reviewed as a
replacement for the existing script (I do not know if that is possible
with git format-patch, ?) I'll try to spoon feed it in a series of more
easily reviewable patches to get where I want to.

> 
> Here I can identify:
> 
> - Cleaning up the comments at the top
> - Removing set -e (why?)

set -e fails the script immediately which prevents giving the user some
facts about an error

> - Moving print_usage somewhere else
> - Changing the output of print_usage
> - Reordering cases in the switch..case for the subtree-name
> - Changing URL of GNU mirror (which very much looks like a typo as it
> doesn't seem to be what the link pasted above says the new URLs should
> look like, albeit working somehow)

I got this information from the person working on it for FSF. I will
review to see if it is better documented somewhere, but this is their
suggestion both the load balance URL to use and the public announcement
reference.

> - Adding new features (each its own commit please)
> 
> You also do not explain what your pain points were when using this
> script. This would be useful information now for reviewing and for later
> if/when this gets merged so we know what kind of confusion happened in
> the past so that potential future reworks don't reintroduce the same
> problems.

I was never able to get this to work by the description in build
documentation. I have a choice to do a lengthy explanation in
documentation to improve that or just make the command more
user-friendly - I will try making it better before giving up and
increasing the word count of the documentation.

> 
> If I remember correctly, the biggest issue was that a pull dts was
> attempted instead of multiple cherry-picks? I believe nobody except Tom
> (for DTS) and whoever are the maintainers of lwip/mbedtls for the
> respective projects should be running the pull option. The diff is too

Yes, this is not clear from documentation presently. The tool should not
punish the user for misuse or ignorance about commit ids before getting
to the moment where they can begin to learn about such things.

> big for DTS to be meaningful so for now Tom is essentially pushing to
> the branch and then notifying people on the ML that this was done and
> that the new base is available in master, c.f. https://lore.kernel.org/
> u-boot/20251008220903.GM298503@bill-the-cat/. Maybe we should also be
> conveying this better (including https://docs.u-boot.org/en/latest/
> develop/devicetree/control.html#resyncing-with-devicetree-rebasing).
> 
> Cheers,
> Quentin

Yes I also plan to reduce the documentation to what is helpful only to
start using the tool and with changes to the tool it will be easier for
project maintainer and anyone else to use. More information does not
make the tool any better or easier to use and for what it does now could
be better to just explain the git commands. I will first attempt to
improve the tool to be more helpful when the user does not already know
what git commands or commit ids are involved.

-E
